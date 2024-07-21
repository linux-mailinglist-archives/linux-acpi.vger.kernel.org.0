Return-Path: <linux-acpi+bounces-7000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84F9385C7
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804082811C6
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Jul 2024 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3C168489;
	Sun, 21 Jul 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiD/5nOM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9129AF;
	Sun, 21 Jul 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721586185; cv=none; b=DmRTgRMRsCuKCik6ZHtRYwIBnsFj5/7NTS/AbBOgP1TWFb/3y5qYfzNvwgjh5/UrGDtYO9OwfSfJvXJ2kBAAAu+K8d3u8N0oT/lJs0NOEIB0/l5+ybUPRxWc9CNr1pQwKCqiwn+5PsPSAqpuEhjwHdzlP6ZzPPkrhClfZ0SfMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721586185; c=relaxed/simple;
	bh=PsBy4cLGJVi7HIeNRgypgVRR5tS7RtNhn3NWwEGwcl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzv7GDwKL+evX4buaP6vVmcBmuCVmV4AzTsax3DCzSqKoFwyZwGUYByn/d3RMVOm6mI1R3mQ2Nzxjr/ZXZJSo0UzPWc4OJE1ukgdWAw66/p7mhYJJJaEBQCz2u1xIttCV+c+NeEfg77+GCQf51wCgrDixQ8ELCMeLZQJ+5t5bFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiD/5nOM; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d9306100b5so2208752b6e.1;
        Sun, 21 Jul 2024 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721586180; x=1722190980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zJZTIIS+YB6nZ9zaQmGQwfdAxpIAvfpVmARDOV44uo=;
        b=HiD/5nOMvz2tPc2k1acFnq93xH6R6oz6Q8y7olc6KP7uxllzpGoqXPns7KgnLCUtmd
         JkO/DiY/TB8OFpvIg4gbP5rU5/MISvbnHVNorLgFvvBAc5Kr2ot12jLXz5hA9pvEAn2Z
         q+V7Qz2+CiLhxA7UVucIKpf+s4TnXKoOPqDcu4gsZX7j9EKEhBKHBZXfyX3j/CftuN6G
         C0yv7zZlBpCLy3NqTIkDUG6NFYk+KL4AcIXAJ3Z5MV/tQ6aSGF7vk65p/g5Ij1kYdv/C
         edqooDlV2qu7Wxl8x8ehQtQA8E/8j0B445i8LOeH1Q2PRMnaPDIctULPh3fKacvDVHa7
         nuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721586180; x=1722190980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zJZTIIS+YB6nZ9zaQmGQwfdAxpIAvfpVmARDOV44uo=;
        b=MhZ7FWL80NpnfSwCVmcw3lV7+BPQPsJJUPqL2YmbE8JJyHEJaoubZCMBha7IF0x1FL
         p13tXp3ZTNjxWCc+yFBXoyinUFgEyL1g80gu/P0r+n7zV9ldZiw25W9VUxJC8YyolBBQ
         Pd+AxXW4onJVB4AhIKnf/ruU/O7yZiZ73FDeNmU9gM/ICDGGxF/fgaalC5YtnetjmizL
         V/kZ/5AHFclvteQv1JQwrINWfl7Av2cIAFky1BlWFhu1XlCXaEiBDzoMsCc4snL56eG0
         2D91kMztd1jwe5EwLPeuqVhE8psvwN9W+NL4R83b0jALMHTQRybaHv8dEXULeXWUmA+E
         uW6A==
X-Forwarded-Encrypted: i=1; AJvYcCW7ufg9YFss+z+tXjmY6uuH2DMo6lmoBP+KE6umiw4Z++oCkDwwWDo0+ixpp3Vvy98Dvdk9S0FjFThWPIfpQemIvLXVUdUlWYL6v5m8VzWTMBemjPoG1PTmZFYmo0Vpls2g4MDZ/3f3W29izayBteGEdFCyH4GBG5sCz6FBxcoOAp72xH6HMNUopcoBhBdFBEd4bgTNriq1F1+nxJpxi90eFb1Nd4j5jk6KB8Rca8nsb+W3BkrxLJxKFg==
X-Gm-Message-State: AOJu0YyJpOp7yN8qBX1/rU6cwSVvTTqRkCW2z0xaQ0FmtbrUGq1nTuPG
	qn6ezm4iEhGEYs02PakPPW7NUAbpgu2N8b6W/5oGTydqrLEJAhRb
X-Google-Smtp-Source: AGHT+IHt9Tdi8370hKjtpI7bea8UmMjP0HfqoLX6MLh4vL255ISQmsN7Vs+ENtHhwJ9arzHwpj4Tcg==
X-Received: by 2002:a05:6808:221d:b0:3d9:e19a:cd16 with SMTP id 5614622812f47-3dae5f48ffamr6912946b6e.24.1721586180615;
        Sun, 21 Jul 2024 11:23:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25b37bsm39302795ad.34.2024.07.21.11.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 11:22:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 21 Jul 2024 11:22:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/6] hwmon: (ltc2992) use
 device_for_each_child_node_scoped() to access child nodes
Message-ID: <07bbf2c9-4de5-4441-a9bd-25b6e5a197a1@roeck-us.net>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
 <20240721-device_for_each_child_node-available-v2-2-f33748fd8b2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721-device_for_each_child_node-available-v2-2-f33748fd8b2d@gmail.com>

On Sun, Jul 21, 2024 at 05:19:02PM +0200, Javier Carrasco wrote:
> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> In this case, the child nodes are not required outside the loop, and
> the scoped version of the macro can be used to remove the repetitive
> `goto put` pattern.
> 
> Use `device_for_each_child_node_scoped_scoped()` to indicate device's
> direct child nodes.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

