Return-Path: <linux-acpi+bounces-8619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AA995416
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A995C1C24FBC
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A01E0E19;
	Tue,  8 Oct 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6DMjVqp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84351E0DEA;
	Tue,  8 Oct 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403840; cv=none; b=hnA+B741Z6RXeGbM/Uwz4y+nuAstqCBptrblq1+UOsPJGGUugo6IERL7bQ39YkzCXfKyJ4iVdrvpKYsBRoY5YpVp/t+xSA99sAcsI8Y+JUqCWP+mcWv1loKVYSbUbYDsIYCtz6+HdROka45fPFjhtcqBuJLQF0ES/E9ye8qTajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403840; c=relaxed/simple;
	bh=xknXWVgHUiP3UwPIEh3pOMCmZWbQWHfRLuGBmeS3A6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCFL+6FczR1OFJicmnjYuUTktkLcLhjHpEgx6HbcEriTk3x65btN7vJa8W+yNXD6r1Px4HWasUOaUCjw5Gb3SIWh3nx/qrXYWD0MGau3SB0NzoG80d0vRqYlAMKB6AnESKbjiw7dDw0RmdNzRaqViUoLYL5hAHO/y2/66YMb75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6DMjVqp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so59328515e9.3;
        Tue, 08 Oct 2024 09:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403837; x=1729008637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cc8Y7IUGEGue3Fw8DnBSs9hs1PN8j5lXcmjkKcBNrs0=;
        b=m6DMjVqpZkVJCU+SWJJg7RhL8AOvIicMS79qujngOtDfeXX7aK+vX6Uj3MfiEL5ZGS
         +tAC3PK13eOE/3YbetYJgfxDKZklqEs/c3etwylzTFwDlB4GMTKblMMLgPGhCSFaUfUB
         FK0cctogfbrY0HXWy41KTzmE0MQ7Y8s/tpBUzENdf/qGVoz/ZE/zBpN1s5trstk9kqrp
         9fuDnJ8Qdz7HY5bwdTyQZnMlG7lLiaZrXwtRT15nVe9Y+A/lmnhkgWpmgK/clwHWqyNt
         4j6lTR4d/lAcku2meutKK4WlG5YnrJ3qoP0jgtPNvfPZuXmih2gNyzK6s9OlS6FvtXsS
         e9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403837; x=1729008637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc8Y7IUGEGue3Fw8DnBSs9hs1PN8j5lXcmjkKcBNrs0=;
        b=ofXtSG0WsalukM+yCvhX1B3BZp2ixDKgQTHpWdWIovrzjpLBEqv4tuP1VOupkneoWb
         gDlQ/ZSkSL/XVGJFso2mIJISRUPrc+Gg/tKgG1HWdYaH8V1Erfbe1YUoOV1gAddtt9Na
         dMFSNo8jWuHQysWKun4awHducH7hqFdVSlvGl6B32S1cGX1Lin7eFGJMLlkRbRmQwaiD
         Vv9UXYEx17EPi3ytaF+wcRCvh1SmxVSWpL76dpZ+ogQtnbaKHJLRMSaHK+USxTj12FzB
         rtsC9Q1Ypio3yNOwdoEfbwF9E2zm9fecAa/BUJc/fsiC/ea29H3wHYmLF4edX610yEvi
         D9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV0KPxaOTOP/S+/NECrcZMP50f1xvpYrCc03UD0CSZmpSAUUh2G2kksH0SZDPS0+R2l4PXkhOCQB2gIUqs=@vger.kernel.org, AJvYcCXct8TeH8gM5Mj90uFyk8RFN19ZwdHseght0bAOfoUyl4VB1x9X6a8q7HzBWIjjLJnJKC+OfXKN@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIiAUSkT85jU1o5qsKFO8K7nRLCXTTcMhZN1h00P0s4yNBY6R
	i81Gbiz0U3Bd5MVhMz9So3Z4/YqRsZ861zY8yqFG/ixcG1/M0QBYRZehiucM
X-Google-Smtp-Source: AGHT+IFDor3IhK8a0JllZQQdw53ciY8fBFQ5Wr7AJbRlHGZl7OPY6Bic4WKwrN1P+M9g7iMYUqtcTQ==
X-Received: by 2002:a05:600c:34d4:b0:42c:b7e2:3bc3 with SMTP id 5b1f17b1804b1-42f85ab9ec2mr125079315e9.19.1728403836597;
        Tue, 08 Oct 2024 09:10:36 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f2f2-fc2e-cc91-5c72.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f2f2:fc2e:cc91:5c72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm113505385e9.33.2024.10.08.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:10:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 08 Oct 2024 18:10:28 +0200
Subject: [PATCH net-next 2/3] net: dsa: mv88e6xxx: leds: fix led refcount
 in error path
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-mv88e6xxx_leds_fwnode_put-v1-2-cfd7758cd176@gmail.com>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728403830; l=1687;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xknXWVgHUiP3UwPIEh3pOMCmZWbQWHfRLuGBmeS3A6Y=;
 b=ijV2P+sGp6JXwfvJ1JMJGMA51s9J1rGHUihsBW00i23qyPP93epMJG/vxA4rYLYIlLgsEMiju
 iLF51WudXTPAkBLVT0Nsc5yEYwakW6sEJ0LcYY5RnCEZZiSEBwRB20n
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'led' fwnode_handle within fwnode_for_each_child_node() must be
released upon early exits by means of an explicit call to
fwnode_handle_put(), which in this case is missing.

Instead of adding the missing call, and considering that this driver was
recently introduced, use a scoped variant of the loop to automatically
decrement the child's refcount when it goes out of scope.

Note that the _avaialable_ version of the loop has been used, as there
is no apparent reason to walk over unavailable nodes.

Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/leds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
index 1c88bfaea46b..92a57552beda 100644
--- a/drivers/net/dsa/mv88e6xxx/leds.c
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -744,7 +744,7 @@ mv88e6xxx_led1_hw_control_get_device(struct led_classdev *ldev)
 
 int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 {
-	struct fwnode_handle *led = NULL, *leds = NULL;
+	struct fwnode_handle *leds = NULL;
 	struct led_init_data init_data = { };
 	enum led_default_state state;
 	struct mv88e6xxx_port *p;
@@ -770,7 +770,7 @@ int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
 		return 0;
 	}
 
-	fwnode_for_each_child_node(leds, led) {
+	fwnode_for_each_available_child_node_scoped(leds, led) {
 		/* Reg represent the led number of the port, max 2
 		 * LEDs can be connected to each port, in some designs
 		 * only one LED is connected.

-- 
2.43.0


