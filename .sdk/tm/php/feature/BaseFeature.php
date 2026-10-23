<?php
declare(strict_types=1);

// XoomarMarkets SDK base feature

class XoomarMarketsBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(XoomarMarketsContext $ctx, array $options): void {}
    public function PostConstruct(XoomarMarketsContext $ctx): void {}
    public function PostConstructEntity(XoomarMarketsContext $ctx): void {}
    public function SetData(XoomarMarketsContext $ctx): void {}
    public function GetData(XoomarMarketsContext $ctx): void {}
    public function GetMatch(XoomarMarketsContext $ctx): void {}
    public function SetMatch(XoomarMarketsContext $ctx): void {}
    public function PrePoint(XoomarMarketsContext $ctx): void {}
    public function PreSpec(XoomarMarketsContext $ctx): void {}
    public function PreRequest(XoomarMarketsContext $ctx): void {}
    public function PreResponse(XoomarMarketsContext $ctx): void {}
    public function PreResult(XoomarMarketsContext $ctx): void {}
    public function PreDone(XoomarMarketsContext $ctx): void {}
    public function PreUnexpected(XoomarMarketsContext $ctx): void {}
}
