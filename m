Return-Path: <linux-acpi+bounces-6882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51293077C
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Jul 2024 23:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BA41F21B4D
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Jul 2024 21:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E692143C52;
	Sat, 13 Jul 2024 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaG37Zjk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5083715E;
	Sat, 13 Jul 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720906673; cv=none; b=Oqr4kSX01GC0r+hx9IZ5vjMzJJDels7G1V4KkmuzSbfJ5R1oLF/sbtJhOm8Afrkmfinm0qV0qOlPJsKk+KwckAQJHCxlNo3pHYELHxtaaniWRX3fDQjOu3511GC7729B1Jv3BLc+U6tPedakRGmtwyM2sx6vTDngQsg8wgo9ZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720906673; c=relaxed/simple;
	bh=br048+ZCXEeV7hh8d9XnZQzMv7EjLwJDK7Qz+EMEaqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWi+ztxSb4VRrXk7roQxrqKz2O5YT3uU8vLqbvoW33y0RKwD5aQuU54gjf87kQsw5+iKpPo5wnom+abC9a5Q916W7EnWEjIA7OGN1iEiutRQwW8IW08GXqRR1o6pfb4fyHObv1ldpE+Ro/aY6c0oj4C1aue3N4LBZOymmVWzszA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaG37Zjk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3679f806223so2446714f8f.0;
        Sat, 13 Jul 2024 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720906670; x=1721511470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWge+wPKweF2GBCVBIBv2ygG3wKeTixMcFo1aegvcvI=;
        b=iaG37ZjkG7x67v9JqiZubumxkPiJNT/6GwdOSHMAdBGlhUjVBgA7u7VtGK/BqwC7Nc
         I6UXryvWltp0zv3UUPuG+9UouUiUdc+XilR62hCR+9BXHqZP82QXxXX8LilP8exXmV36
         DVEAW9WeBQ/iezwVcjpbzomzRzoOF7HH+7AU3oDzDOUD5YcSYS4v2x9EyGdbG+XnqWo/
         3sCfhaHUsX5CycCbTI2qOC/4J6PzkU8LEEhH0YO9WaNW4g27hHT9L/yXRYAsNAx5xKnJ
         2Xx7iRrVfXnhLmGfMZoDpb0QHp0rJFnJYro00K9zEsKGmYD5ivlXuGhOHW4f7PDOr0oS
         UjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720906670; x=1721511470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWge+wPKweF2GBCVBIBv2ygG3wKeTixMcFo1aegvcvI=;
        b=gOU7B9vosYTv7ePvkabC6Rf7dHZ9XbgAx9ZMv8jWq98uBc0Ij160f+/7ey6xspPs0Q
         C9ktw7CEyBhKD0YeEnWlz5RraqCs3ir7zWpS9lMGT2N7DZ4EPEb1ZsSiWk/Ln6JgjaDa
         IfgRniH75EXcWWv9E+uAPojWybU3qziuqNF9sBlf69BDKK4Krw2vJZ3oMxVgzvvO364P
         d64V80zgzcU4gbH2qv6p+AXp/VlZ0REQm2Y4Zmy1e8Dnb4CsPuRo5pGml8Y2mp0EWMy2
         A8+UCHV6ULMS8x33AYVGw9wtL6uKJVBWeV7b62c8AzOTeYvB3A4dXK5S53YGo4ODvDyW
         lQiw==
X-Forwarded-Encrypted: i=1; AJvYcCVHK2sqKphHPgaAtbKeQ8R2FWSCTcX3yVgYFGCv+BXkcTRTMNtpmoLFIS8qFu4tq3MJAiTTB8yKKspAXMh+U3AqN4j9gLaK8ZoR/ntV9/qcjzaYloYXzQkFDPnWUlt3csRRFdVGa1ee9PDiALQR9BQwrihB7bz33JlBOnGO5WvMxzguBTsPH7Iq7Q8qNX5G4y3878JHuwcxjBffhmiCCY7JOmMbB13XuJCDbZQr5PV6yHULJ8tmb4z0iQ==
X-Gm-Message-State: AOJu0YwI4dbiFmJDEHiVe3CbUTLfvQEptNzR5uvd+rFpQt886Vu7BPbl
	JbIgFIuTMeCTTqci84hGfw6+s4aVVGt9dI+5rzr9fDcXF7mdyg77
X-Google-Smtp-Source: AGHT+IFtFHfQbEmui8gyv0uER4jCDezZch9KaAtTQYCcQnH2LXfnaNOUq0m3eU4lltdgXGU4ehxnsQ==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr4637223f8f.34.1720906669552;
        Sat, 13 Jul 2024 14:37:49 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:8180:f721:f9cb:10b2? (2a02-8389-41cf-e200-8180-f721-f9cb-10b2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8180:f721:f9cb:10b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3b41sm2426542f8f.5.2024.07.13.14.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 14:37:49 -0700 (PDT)
Message-ID: <4f996369-2959-4e17-917d-f2de48d22064@gmail.com>
Date: Sat, 13 Jul 2024 23:37:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] leds: bd2606mvv: use device_for_each_child_node() to
 access device child nodes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
 <20240706-device_for_each_child_node-available-v1-3-8a3f7615e41c@gmail.com>
 <20240707175713.4deb559f@jic23-huawei>
 <4cf71de7-dc47-475c-bba0-a9e755f66d49@gmail.com>
 <2cd45260-e737-43e9-9bf6-c267d6f86ad3@gmail.com>
 <20240712230656.67e89eb2@akphone>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240712230656.67e89eb2@akphone>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 23:06, Andreas Kemnade wrote:
> On Mon, 8 Jul 2024 17:45:43 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> On 08/07/2024 10:14, Javier Carrasco wrote:
>> What was the reason for this modification? Apparently, similar drivers
>> do everything in one loop to avoid such issues.
>>
> The reason for two loops is that we check in the first loop whether
> broghtness can be individually controlled so we can set max_brightness
> in the second loop. I had the assumption that max_brightness should be
> set before registering leds.
> 
> Some LEDs share brightness register, in the case where leds are defined
> with a shared register, we revert to on-off.
> 
>> Maybe refactoring to have a single loop again (if possible) would be
>> the cleanest solution. Otherwise a get/put mechanism might be
>> necessary.
>>
> I had no idea how to do it the time I wrote the patch.
> 
> Regards,
> Andreas

Then we could leave the two loops, and fix them. I am thinking of something
like this:

 static int bd2606mvv_probe(struct i2c_client *client)
 {
-	struct fwnode_handle *child;
 	struct device *dev = &client->dev;
 	struct bd2606mvv_priv *priv;
 	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
 	int active_pairs[BD2606_MAX_LEDS / 2] = { 0 };
 	int err, reg;
-	int i;
+	int i, j;

 	if (!dev_fwnode(dev))
 		return -ENODEV;
@@ -93,20 +92,18 @@ static int bd2606mvv_probe(struct i2c_client *client)

 	i2c_set_clientdata(client, priv);

-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		struct bd2606mvv_led *led;

 		err = fwnode_property_read_u32(child, "reg", &reg);
-		if (err) {
-			fwnode_handle_put(child);
+		if (err)
 			return err;
-		}
-		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg]) {
-			fwnode_handle_put(child);
+
+		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg])
 			return -EINVAL;
-		}
+
 		led = &priv->leds[reg];
-		led_fwnodes[reg] = child;
+		led_fwnodes[reg] = fwnode_handle_get(child);
 		active_pairs[reg / 2]++;
 		led->priv = priv;
 		led->led_no = reg;
@@ -129,7 +126,8 @@ static int bd2606mvv_probe(struct i2c_client *client)
 						     &priv->leds[i].ldev,
 						     &init_data);
 		if (err < 0) {
-			fwnode_handle_put(child);
+			for (j = i; j < BD2606_MAX_LEDS; j++)
+				fwnode_handle_put(led_fwnodes[j]);
 			return dev_err_probe(dev, err,
 					     "couldn't register LED %s\n",
 					     priv->leds[i].ldev.name);



Thanks to the call to fwnode_get_handle(child), the child nodes get their
refcount incremented to be used in the second loop, where all child nodes that
have not been registered are released in case of error.

The first loop becomes a scoped one, keeping the `child` variable from being
accessed anywhere else.

Any feedback before I send a v2 with this is very welcome.

Best regards,
Javier Carrasco

