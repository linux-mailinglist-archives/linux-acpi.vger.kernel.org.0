Return-Path: <linux-acpi+bounces-17283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE128B9B811
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE404C317D
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171102D9EE1;
	Wed, 24 Sep 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtBmNeMB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77FD2848A9
	for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738974; cv=none; b=LxAwLrYRCs8oNKscg2zfuoFl/UK+cZ8NGEAVV+jT+uqybFK6iDABEpSwQG/hU6/FSUztTSwOBAmik9FLMap5R8xhfgz0Sw2xZKlSb5RLxAxFTarEhvHzYfW7WscEkpzwkqs0sr/uCz0+61Mt5I3GG/kyQN9KKhI5ChPWPpXWuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738974; c=relaxed/simple;
	bh=2aLfX7a8qrLe04EEuCsSWXOjT7NO0ExrjFnQIBlHj04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di6EcXZ+gbpmDlza+uMh/HA9sTqNIk+UNYH092OjiSyic103efFl/YRI4GAfbNDwAFg1H8N06EER7SrchcowLFoSw1pWYxKFb7wHyQ221Mf6uxxfXJwZpgPLw3tvazT/23RLebMwixxlCYdx3AG7Ik/i/Ch9JbaNk+1wlClr+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtBmNeMB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eceb38eb1so886675ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 24 Sep 2025 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738971; x=1759343771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuMDAryKyhqMDr6B+XSq4gaOR0tjLhHQ+hf5EwbyoXs=;
        b=FtBmNeMB04FY3JGB6PNvtOFMiiWfAj4garK3jVjddYu+aBCpnKJv62bLvq1W//T70a
         y4kpNyp7rAle3Axx60PHhi6UEdug4mVpmTWaiXKH7HrgfEK/PWpxCcW0GSz76SJe4Dr9
         occhHLHIxPq0kTA95Jz5yBEygNFimb1rEmkA1gh+VV5Pqlk8iMz81SJJZ0+AJISXUxZt
         wdtaeEH1wwkn7kSP5ttEoRqBmeHlsXKKhB8JQMcokPHbGgOVheMDGjqihXZULw08wYio
         ZlNFk+yeDUGN96q/XFWEIvy11lkr81KqELV2YRixghqOF9U1I8bvBJ6ZhOrkKSss3XPz
         GONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738971; x=1759343771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuMDAryKyhqMDr6B+XSq4gaOR0tjLhHQ+hf5EwbyoXs=;
        b=o+K+LvpjHFo1+3uNKzbr952MteCvcBom5bXvt+xMQYg5DhjXEtdy3cF3JEFV86L6hm
         9oKggvpOVpzlqIRQjhRJxxnnX3FnhyMyk3YzbQCmjENwhSo12rHtL0XSZ2srWUZ+5zXw
         fu2TYs+AblSl2uIg++Lg4MV+vAbmXRKFPShNBh4T/+jGb4LxB80RIzrPCFZM+xHk8H7+
         DiUm8OG7oVoCOvkQFLBbIaUfCB7KdxRl3M8ZUukYWhF+CMwUVrJdfB0Am1/w7IcYH/fH
         yKT5hbo/hozihj1VJsebE9rFIFML7tVLWOnjU2w62ykRXxkVxwMlX1aWPapOQZSjawiM
         BbEQ==
X-Gm-Message-State: AOJu0Yz3lFxeM6+U9ZUKkB7X9lsISp5W+bGhZCGMda3MzBPSkWNbW5C6
	plCywmPO3J+8JYJ6Tn9/aK6RFw2mHIMTyET+0XdvBEhwUMkpj+dcRyoN
X-Gm-Gg: ASbGncudx1p+rGLdoFp0rv0TsvS6711FwNCFrW25xKJwwiqAwQckbYSvMIzu5Y96Axz
	3M1dKqhQ7J5XhfP2Ks0DJP0tB7mTrekhVKl7RaDYE9yycBpZMsmqjIV96FHH+BkFyeN5UFkMiRn
	r3psQwhUw2sVMfrsUhf83OmX9J4M3eTdjPQ6jUJ457/yCkS3XPeUoucEIzBmq/F8Z3tztttuzBJ
	yLcNRTjOOQbcAeM8b+VQMOYTt13CjrLWtCCM+/Ma19zyMbHom8ROAdJIVcf4VxnuqHUnJChnYAo
	T47E8uOIZLtsFgnx4hLZ5alSSxuFkr02PZWpntWLZp8UNUsz6EN/0eoTc2zoSiQFuT2sYS4R2Rp
	F/v13rSUAuR9ywbQk/2BdYJI=
X-Google-Smtp-Source: AGHT+IFpCuPX+NdIWL+u5IkcBx4+VbKV/4827jy+s9/WEKKxG/dZ2BXBXewNNRlOFgtg+akJrLG03A==
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr5732905ad.27.1758738971104;
        Wed, 24 Sep 2025 11:36:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f4c4:bad6:f33e:ddc9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90367sm3096304a91.5.2025.09.24.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:36:10 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:36:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Javier Carrasco <javier.carrasco@wolfvision.net>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matthias Fend <matthias.fend@emfend.at>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/16] Input: touch-overlay - Use
 fwnode_for_each_child_node() instead
Message-ID: <amnjiro7qhreys4upoh6ggqurom6gudk2gw5ayrfjhj243wqwh@o4hf6txhsm62>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-12-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-12-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:57AM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/touch-overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
> index b9fd82c4829d..7eaaaef1bd82 100644
> --- a/drivers/input/touch-overlay.c
> +++ b/drivers/input/touch-overlay.c
> @@ -82,7 +82,7 @@ int touch_overlay_map(struct list_head *list, struct input_dev *input)
>  	if (!overlay)
>  		return 0;
>  
> -	fwnode_for_each_available_child_node(overlay, fw_segment) {
> +	fwnode_for_each_child_node(overlay, fw_segment) {
>  		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
>  		if (!segment) {
>  			fwnode_handle_put(fw_segment);

-- 
Dmitry

