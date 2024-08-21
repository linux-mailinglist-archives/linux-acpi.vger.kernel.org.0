Return-Path: <linux-acpi+bounces-7746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556139591DD
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10553284D9E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA01E50F;
	Wed, 21 Aug 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfzQwByI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDDEEC3;
	Wed, 21 Aug 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200435; cv=none; b=K82u30wAy8vLg5Yu+RqgKlHhqBTRlWAAPdpD5PJwAsEDV5HP2t9ooRtGJlsAL2kBJCfZ2QNsni1V/vl4B6YncfiR4q7IEA9mGCga/ahZzfW+8Sb3QLufX9ficK8BnK2tjIwP7dKiRLO5D7suzv0HKW5AVx0T5tI9/dbTEoQqM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200435; c=relaxed/simple;
	bh=Xf3imji96YqaMFd4fO6kQzmpIvadXk3qPXsC/skPVVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7RhJYUr95xFe8HL1RHJFm5gGqcweFG5bTclzsLhyCFSPZ0AaYdet7REfvLrMZjdDIsOQzBu2DozZiwl32Jd5BE67fMEPbJs/T/lsLsczViS1mzKCbkC2OeHvjscDNQZ2oHOKtfOQ8kNbNi8LW4jt8bSxkSxJHIvet/FSj9t3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfzQwByI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C612C4AF0E;
	Wed, 21 Aug 2024 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724200434;
	bh=Xf3imji96YqaMFd4fO6kQzmpIvadXk3qPXsC/skPVVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfzQwByIP0BAG/fURq6B1rZ6UXueihVrnguj20bZII+z1M6RiesR/JB+tBe4S5pji
	 265mnvtx235ji3oR5NFvFGbNdRCiP/KbSV7wyZ6cTXPMF0k8g8bIAG+YxsNaLhgnl1
	 lSxkQPtaTL5q4ILYNszYFR3xdq9mMu5PczDAZoDXnEJ6tFXrdb/W08r/HlUnJpwkJ8
	 QL4REKBpLyJIw1I+7pW6AMUStdrkSIORTtW9vSZjhvhO1O8vHi8uvm34+Cu0mrq82u
	 nrqjZIjZQZPq6aayjdDYzMyPdA2GAWSAKYkf0SkRFqnNl5s49ncqLQeKbISNbhSV4i
	 CnhF8L9gLkZfA==
Date: Tue, 20 Aug 2024 19:33:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Pin-yen Lin <treapking@chromium.org>, linux-usb@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, Robert Foss <rfoss@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 13/17] dt-bindings: Move google,cros-ec-typec binding
 to usb
Message-ID: <172420043081.2347279.17919615150697401810.robh@kernel.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-14-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819223834.2049862-14-swboyd@chromium.org>


On Mon, 19 Aug 2024 15:38:27 -0700, Stephen Boyd wrote:
> This binding is about USB type-c control. Move the binding to the usb
> directory as it's a better home than chrome.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml     | 2 +-
>  .../bindings/{chrome => usb}/google,cros-ec-typec.yaml        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/{chrome => usb}/google,cros-ec-typec.yaml (90%)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


