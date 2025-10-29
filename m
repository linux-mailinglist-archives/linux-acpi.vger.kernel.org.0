Return-Path: <linux-acpi+bounces-18328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02836C1A669
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B96E3434D2
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797D350D70;
	Wed, 29 Oct 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NZzxv7Ks"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4993446B5
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740936; cv=none; b=Msj8q2Ts8T7mkbhLebPJUsGqdWT/ebUmJ5whily7AtWyXXB5jIi2FZsemgy/hWPpioiHeUivap28qYGuzxqZkk9LxmipMCjPb0153ATBNwwcezOvf+s79ngCcxwvP5uD8cgjqJS9R6DGUMzEb4BSDm5y/JVBbmIefcxwzlOTdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740936; c=relaxed/simple;
	bh=Qs8vhyOoCvNWF0j+x9Ihy0ZSJH5YgR3lWq9+JQ16CJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH8MdwgRxnVVPjrGvDOPLaXPglm7OTmaKeh7NLBniExNuhsTjebNTSUZMQnj7Hg1cEKPZU2rPA2F3lqj96/D2RnlSGmH8AeQzZqruKEZcltgRLuQT8MRj99RkwKWTXyzB6aGb71phFd4JxwF6lZM2Ow9OsHU3qteQHv4hBG9lwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NZzxv7Ks; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so45742415e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740932; x=1762345732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxAcLRLFuFPkJ4GNJSGN644S0txZ4Lw8m8ySKDPzrmE=;
        b=NZzxv7Ks+XjtNx5wIB3Bs1xHyX4lvgEOipXxeNEmlE0eaEbppGFfMEuc4IkjbSS6KS
         4kuziF86TJn4Aiff+Gm0vKYZyHltIuswu16BA1+nzfpEN1XTBjUXkYirsXdpt3GCW9BY
         6YPxkkZmJsB1Ny3/goUBbJreqlI8iArT278bGo20JRPf4rA7+ZW8uJ2FCdsSSrcgNk2Z
         F3o2L8ASMjo/w5uEv65FK0ykTk2AEnGDJ6tS3OFehBTD+rrcqNczZqwnMSvYV6H9XXPo
         QduL2BXnz6/1WNvt2Wu76NWvxkVROlDT4I1WbOXhUqMKAoxwZOOMxZ3oOhWyTYZq082w
         cT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740932; x=1762345732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxAcLRLFuFPkJ4GNJSGN644S0txZ4Lw8m8ySKDPzrmE=;
        b=mX1JJ9yPa/DoqgBB2N6stT2c4BtohwnRqksiz53CGnHk6bI1uUorWq3kUfKNNO7fSk
         yMU7YrDAHikBu+RqQyMm3V6TzzqTfjPFSykGm+KiuXVcQ7ChpSQb19Huz/X7766VSMkb
         UZYSCutYztKe+5j+l1yiDONel9tg62jef/6EaeZmQY6b57Tx74y5dcIi4YLrqmBy/oQd
         eF4QlpWoDgIDaT3ibgu4kxRpI+rYCZfcaL0Dpx5FFUMCBkTF3/AKkA3M82+kdC69qfop
         tMkRwxqnPTZAnflEGhya/ONzm+Iz3qFUxROzE0d6p7tiIpJjjfYrhLS7ArmvTr3nkWc8
         k38w==
X-Forwarded-Encrypted: i=1; AJvYcCXetpL9d9K/ljYgwGlnrrIvd2QBg5K49XQCiM+bQQwPVdbbIaRz0PNzMe/lHf5mqH1hukOtQZIPp3jA@vger.kernel.org
X-Gm-Message-State: AOJu0YzebS8v3zxs6naz36z/G9ROVuKGZzHnykv8OP79aUtgW+6SQ/+r
	P5DpxrdJvzNvV3iOJZFy3Xjyti3lbZxemVQ5DvY5je01PKwOoIDlblyvajWeILDsdAM=
X-Gm-Gg: ASbGncuYYyv2W2/ZdNzAIG7QPI3JF1a2tpUcsMkbUHkZ1dbmszhZbe3hJfdLi6EVS7t
	NJ7q2g0ZWatwkcY3pFWx7opgJKHFk2PwE5/tl2YSIfP/XQyy/BOvReRiZ1j9AOSPq+Ne9DIStmR
	/rpvIJ4So2mpGEM4URBXCw3T5I+cXwQ4liyFCugeyvx71/G+1DJzQY/S033kBzvwz6IpVdP00Cz
	snbxE01FpvtJ+jm88yMiIAWQvPl20j5MzlNg35A9dKjqkpTdijyH7Iifzg7oIxHFnw97hNFkFKi
	ldGiGtpW7r571RhSqhbjhEMnN3u85vHJ+FiPgKb6dmB3b4M9oulzS1rsQ89wrDORTr+H+0/aHnt
	o/SPZn2Ew3548zxZpPjk4m+FoVkCODxAplsJE2M4mGp6BIMzjWfQYVRBhmR1LFQHGF7P12kNMVn
	MWYS7E
X-Google-Smtp-Source: AGHT+IGVSIyGHooFUNwJFOzgP02oaNQfaoSa8LUBv0H67C8L7NLZJDtS9Jjx7pnxWYORGUjGIOom5w==
X-Received: by 2002:a05:600c:474d:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-4771e1ca0d4mr27882115e9.23.1761740931794;
        Wed, 29 Oct 2025 05:28:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:36 +0100
Subject: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=905;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=4MJAfoZ4MOXSK/aVI5nkAQoTezWuvKeaMoxZLush+B8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh9qP5RDqvLYPjRG0kK7LDKyqTLSCgKta+GS
 Bb0AMsCovmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfQAKCRARpy6gFHHX
 ckQGD/9Wr1DFAlSPL3hjFIONxOnWJ6VUG431FxgF//U0pSgA4H8G3zZFgceXMnkJqW4o3ScMRoY
 uaMVFq4opsSZpwSxT9yO0qsiajx5QASjjn+Pw8QaCJcNos+7cNIzx/5zz9UBnb5PGns5dpkqLLA
 N0pA7Hv2Ky+2A33aLtCPTOJ8UbwmGYwHiZGTg8p/CZqx6/eql1WnLE+FKxSFaHDaDll4x0vEuvL
 muHhKFO5rpTmUwdevO+ohSWt2atNyyUlTl5AazOI6iohZ+/G7NsFw/eFzKzYRceA53ejPTUCM9f
 iW4ymxHNqxnib9It2M4Mv4D9Q6zjXyhSCqY9jTAWTDNaR8Mk6dh62OA2ftBxW/tKEwECYQAsW25
 Mr0OEhtB3SvBOvPPyvKXKP+vO6k6pu2S0CC57Hf6X0BBRuZWQYqGgXAs8xdxST/EyrZ8xaQAMWl
 GYQg5IDNN3ole2frFNobuFSFnTJpJE6I/Nb74J5bkKB5m5OznDnlgLTfncVYG/xDTDoXhmtsEGM
 wlwguFgWGS1Tg6u/EpeQpmEXP5tWrUE/qWuGJcT1n+G71LimrgFJhqPTLuxaAGeKCymYfNjN/TG
 zPj1RZYS4CzdYmtL/djXlKQ7xoa7Tb8SskZmAxvJPMh+dOWrmVlnh3vCqKuxWzF9/b44wMvLGVb
 MVpSAkTAqVelzxQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference other kinds of firmware nodes,
the node in args will no longer necessarily be a software node so bump
its reference count using its fwnode interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 2994efaf1d5d74c82df70e7df8bddf61ba0bfd41..b7c3926b67be72671ba4e4c442b3acca80688cf7 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -554,7 +554,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (!args)
 		return 0;
 
-	args->fwnode = software_node_get(refnode);
+	args->fwnode = fwnode_handle_get(refnode);
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)

-- 
2.48.1


