<?php

namespace App\Entity;

use App\Repository\PostRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: PostRepository::class)]
class Post
{
    const STATES =['STATE_DRAFT', 'STATE_PUBLISHED'];
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(type: 'string', length: 255, unique: true)]
    private string $title;
    
    #[ORM\Column(type: 'string', length: 255, unique: true)]
    private string $slug;
    
    #[ORM\Column(type: 'text')]
    private string $content;

    #[ORM\Column(type: 'string', length: 255)]
    private string $state= POST::STATES[0];

    #[ORM\Column(type: 'datetime_immutable')]
    private \DateTimeImmutable $updatedAt;

    
    #[ORM\Column(type: 'datetime_immutable')]
    private \DateTimeImmutable $createdcAt;
    
    
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): string
    {
        return $this->title;
    }


    public function setTitle(string $title):self
    {
        $this->title = $title;

        return $this;
    }


    public function getSlug(): string
    {
        return $this->slug;
    }

 
    public function setSlug(string $slug): self    
    {
        $this->slug = $slug;

        return $this;
    }

 
    public function getContent(): string
    {
        return $this->content;
    }


    public function setContent(string $content):self
    {
        $this->content = $content;

        return $this;
    }

    public function getState(): string
    {
        return $this->state;
    }


    public function setState(string $state):self
    {
        $this->state = $state;

        return $this;
    }



    public function getCreatedcAt(): \DateTimeImmutable
    {
        return $this->createdcAt;
    }

  
    public function setCreatedcAt(\DateTimeImmutable $createdcAt):self
    {
        $this->createdcAt = $createdcAt;

        return $this;
    }
 
    public function getUpdatedAt(): \DateTimeImmutable
    {
        return $this->updatedAt;
    }

  
    public function setUpdatedAt( \DateTimeImmutable $updatedAt):self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }
}