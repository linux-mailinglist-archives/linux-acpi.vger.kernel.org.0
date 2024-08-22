Return-Path: <linux-acpi+bounces-7781-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DED95B6FD
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DC3284438
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF561CB318;
	Thu, 22 Aug 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6FxQOIP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A01E50B;
	Thu, 22 Aug 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333969; cv=none; b=Ck7+H04FnkdhuFLzybUNMZ4dVDiC2j2Ma3XsqHodPqrcsOWubCf/GxUGDk0ECa29VQ2CH3SAT3is8QxVrYekzrcCRER/VrUhC3DoYP5rxiRbxPZGWmMnZIzHnVwdLoMielbc2J+jVh3zuNYE2ywbMvJsklabS2yHPh5+SlWkG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333969; c=relaxed/simple;
	bh=6IIgjYTrddV1aSYFQjhcxaP8pZ0PWHR+oYTSh+0LoJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWuyG2UND/oeEHIiLe5ZO9qhQvZ+sk6xPBhOpVWNzeu1E1OuzTU2uqatDFpHfY56/ke1FTx96ECKe4cTOGr4/ZT5p2IF0KFrXzDROdOVsv5yb8B8FIlcCVZcP3cbpk9SWOP6iklhXg2qmvRig8QaNfA5GYadWiSUcHJLEe5QIxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6FxQOIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C55C32782;
	Thu, 22 Aug 2024 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724333969;
	bh=6IIgjYTrddV1aSYFQjhcxaP8pZ0PWHR+oYTSh+0LoJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6FxQOIPbB4y+ZT4Jd2c2fZQdQwaYSbO/3tC015s0JhzWXjq6o3MFf4MPGkgh1cTa
	 iixXW4+KAn9Fix+9gHXTRdd7sTLdRdg2FUxC9lbo+cwfaq5WnTZ5fR5YelQ5nUKHAk
	 vg5p6yyxsv4IsVwDBWtSxFDP0Bsssfqr9yrDokWhQyGvEi0hDC7coA2Dj1rj+O/KVu
	 p+dYeapau7QsNqr85TJ41UZeRuw2QdYZpHg0mrlOJv6MML2w1wconUqdKuZZawyXKL
	 vqWS6DxC2ZIjaSr+dWf29zPlMZ582Ty+wfsV/EZGbQ1AgNFTJ9f9JSaqHD2+CtNIQV
	 1riDeHM5HcV4w==
Date: Thu, 22 Aug 2024 14:39:20 +0100
From: Lee Jones <lee@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 13/17] dt-bindings: Move google,cros-ec-typec binding
 to usb
Message-ID: <20240822133920.GK6858@google.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-14-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819223834.2049862-14-swboyd@chromium.org>

On Mon, 19 Aug 2024, Stephen Boyd wrote:

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

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

