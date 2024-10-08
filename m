Return-Path: <linux-acpi+bounces-8618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE131995413
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692531F2615B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3AD1E0DE4;
	Tue,  8 Oct 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJjeFNf9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C891E00B1;
	Tue,  8 Oct 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403838; cv=none; b=kHXyflo/ongw1fEVCqphwPZMsWg13L7rfVy8SRgxpLEHmLHYtKW7NfxZ6wlkLcVlT544KIUUV1jPP9yNstZNE48oIa869P3FtldRLvMrUuff9EpulOr+7CTxn8J3rGx7h0JmJ/Nr1k8JWZyPjoI7h7nlI1xxg3qgWfjp+ne87jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403838; c=relaxed/simple;
	bh=q5vUQZfbwy6fRP5D3eyH3Zp44IozpqyYJHBzw+URkbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sc9aksXKBwVah8Cl4BomkdpES7kKNXjNbWBpAmSAtvdEQT2V0c21X/QqyYZ+5Csa16pZU0eXVae9Uh1xCu/+re9Enc7vqlv7Hmyq4VHVjLY4SpRjrYT+dtGlxH8N5igtbf3Ifa4C8YsOZV0Y+6FyPDutf+YgCHNYKwi194nOD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJjeFNf9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso52355515e9.2;
        Tue, 08 Oct 2024 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403835; x=1729008635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dr6wb9TLKZZRAzr/ix7ApfkEMcDHa3kPnrh21DGwKY0=;
        b=iJjeFNf9IZXZsaQsEJ11lmf4J2x7RJQGra/+UuZn4i04CU79YPyESduAjJBM58mUIr
         qONPzsCQF1jeb+JupaIdyTekua2uLe/L5mf9mBJ+M6XkvcAHJ+YtIFFNTzVDDQWCeUtq
         jlxLwYby0EIPiyzS5w9TCvWcr+NeNarkuu6n763Rp7prJmUywWVWvC1zhrNecqzj6B2Z
         3C+nNEvEDDVe2dlwPLNFSFQhyUr+bxMYO1KC/e3pRyVCBaRAmCQeg605FKBu7UL3uTdg
         P4iF5XnsBoDBeI/jlPGIl91dMH6flheCEMyNBARkodeEy8qU0DhSm5WmQqZsactz4aj2
         1Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403835; x=1729008635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr6wb9TLKZZRAzr/ix7ApfkEMcDHa3kPnrh21DGwKY0=;
        b=Ys1ZYlPRky8bY+DQXypj05+fymTuT6vETsI9D7bWKPYHEjgCjcMzSdsTO2BTvykBdF
         9/YixKbwj4Zb5rL5iLyZNrnIqDneJGLIzzZacdusdRtYt5+K1Ejdp/endTGdqytp1hHu
         0Eo30t7v8h2scLfwyxd5n+4dIvchdVAfEmFdZJV1+Etqog/E5OBOUBUlm41HMLL22ZB4
         6ie2Y74kMgcPl7Veu9JtTRwrTyVyMM4OKJ/s1E+M62V19Klf4YpZOX0lokTmq41YHH4l
         uyTVVisSATTHa7ZCVG5MFvqVLfm133nKn2KYVWC+VaPyUOSXd9/3reoN2gtARoerF2+L
         mRdw==
X-Forwarded-Encrypted: i=1; AJvYcCWhHGTWDrv79xVNA0+ToSXm7IeyxXTWR8CENSraZ/MulzUFrkv9S87NKkBF9wOcPV4FFT4+XYDa@vger.kernel.org, AJvYcCXR42Dpe7dLPQoQlsMIbTtlcOwTPk0/Tq1YOCUMnUihP2EgF4zgaohfgwt4wlFfkX8jkZuxbQZGOHc7n/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccTaLdGzbsO3yDFWEeDmXP1zXJpMlJo9NjAQB1kY9JSDnWGBd
	QFdl9R0EtEXCBCjojbK5sdcBPFz2WyEfaq6hyiK4k6H3raDyflsYu0d3na8q
X-Google-Smtp-Source: AGHT+IF2odc1Ix7mWrUlJdgxfmoJRjWJRyk4eIzdmT15VsckyY3Xh34gSdt13mk6BPONgCaallmTYw==
X-Received: by 2002:a05:600c:5111:b0:42c:a802:a8cd with SMTP id 5b1f17b1804b1-42f85ab5dc1mr119111795e9.11.1728403834767;
        Tue, 08 Oct 2024 09:10:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f2f2-fc2e-cc91-5c72.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f2f2:fc2e:cc91:5c72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec71aesm113505385e9.33.2024.10.08.09.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:10:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 08 Oct 2024 18:10:27 +0200
Subject: [PATCH net-next 1/3] device property: Introduce
 fwnode_for_each_available_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728403830; l=1183;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=q5vUQZfbwy6fRP5D3eyH3Zp44IozpqyYJHBzw+URkbY=;
 b=F0T9Rl8gnijwBYmpOUjkTZW6Qpy2HjLQPqMBRKW2jY5vTX0cm1TaLz0xgA7QpIpnveTv0GnwZ
 YsXJ7vwJTTOAAHwfqkzaEcLE8fiKShk2NHQVF79Nh/d52C3vOMOxt/s
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Introduce the scoped variant of the
fwnode_for_each_available_child_node() to automatically decrement the
child's refcount when it goes out of scope, removing the need for
explicit calls to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 61fc20e5f81f..b37508ecf606 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
 	     child = fwnode_get_next_available_child_node(fwnode, child))
 
+#define fwnode_for_each_available_child_node_scoped(fwnode, child)	       \
+	for (struct fwnode_handle *child __free(fwnode_handle) =	       \
+		fwnode_get_next_available_child_node(fwnode, NULL); child;     \
+	     child = fwnode_get_next_available_child_node(fwnode, child))
+
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 

-- 
2.43.0


