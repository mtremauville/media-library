import { useRef, useState } from "react";
import { motion } from "framer-motion";

export default function CoverFlow({ items, onSelect }) {
  const [activeIndex, setActiveIndex] = useState(
    Math.floor(items.length / 2)
  );
  const containerRef = useRef(null);

  const getTransform = (index) => {
    const diff = index - activeIndex;
    const absD = Math.abs(diff);

    if (diff === 0) {
      return { rotateY: 0, x: 0, z: 0, scale: 1, opacity: 1 };
    }

    const sign = diff > 0 ? 1 : -1;
    return {
      rotateY: sign * -55,
      x:       sign * (absD * 180 + 80),
      z:       -absD * 80,
      scale:   Math.max(0.6, 1 - absD * 0.12),
      opacity: Math.max(0.3, 1 - absD * 0.25)
    };
  };

  return (
    <div className="coverflow-container" ref={containerRef}>
      <div
        className="coverflow-track"
        style={{ perspective: "1200px" }}
      >
        {items.map((item, index) => {
          const transform = getTransform(index);
          return (
            <motion.div
              key={item.id}
              className="cover-item"
              animate={transform}
              transition={{ type: "spring", stiffness: 260, damping: 30 }}
              onClick={() => {
                setActiveIndex(index);
                if (index === activeIndex) onSelect(item);
              }}
              style={{ cursor: "pointer", transformStyle: "preserve-3d" }}
            >
              <img
                src={item.poster_url || "/placeholder.jpg"}
                alt={item.title}
                className="cover-image"
                draggable={false}
              />
              {/* Reflet */}
              <div className="cover-reflection">
                <img
                  src={item.poster_url || "/placeholder.jpg"}
                  alt=""
                  className="reflection-img"
                />
              </div>
              {index === activeIndex && (
                <p className="cover-title">{item.title}</p>
              )}
            </motion.div>
          );
        })}
      </div>
    </div>
  );
}
