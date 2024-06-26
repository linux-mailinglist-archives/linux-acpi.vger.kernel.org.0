Return-Path: <linux-acpi+bounces-6619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA0917F56
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2717DB225EE
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7F17DE11;
	Wed, 26 Jun 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/Ve4L2E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7CA136663
	for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400512; cv=none; b=l9OyJOpnadCllcOims7pOnbCB8PTgkjaQtDk4HpyK/7LFoMIvwqwx0B+up10sNfWTdfyKQOPWrKKjjwNW8M0SdGk4Mt8gee473DeVKzTzPhwspAYjOVz8y8+maAaDGx0YZhcJg2K9IQXamdV1qUt1ISpNhaWeNQvtwrgTogXHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400512; c=relaxed/simple;
	bh=t8qhivKDKPOSTflXmOVXK876XjnpsuUegiSXWAWo/kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq2O8EgpiXLzVRtOvJKplaI3ubRr8Ih2eZ0bHGrIfWZoGLf/KdOHO3iAwwYtoe60sRJkR/fcbs7AH4gysncdu8+gl5ZZKtrW7PezqajfJIeqnSs15pG6S8zErRIxSYfH0aPyY6gf5A6cyxkefHBxOrxAJjtq9tqbGeJ7vsdgSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/Ve4L2E; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ec00e71a57so255523439f.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2024 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719400510; x=1720005310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbQ9yTrKHIUgvEQYgg/gM8+VqeT6Z6yVUnnBdLfHz5Q=;
        b=f/Ve4L2Ea45+2wtr1jLqpfAFkbPXURTVrl4RX56auFQHoJNzwplQ7tv3eob4yGwzWC
         SfLBZ54zY0TFQGenX94/QvhLgXuYq/hwezLemUqJlESMB5qBnl5ep0OCeF7JaOPFAkzh
         31lykX/bicEy8hBmFRiP4ui6Qna2aF0UMx8uO2gvA+2k94lQp5HoLX+MdwjgNymZGOaG
         prRAH2TchgY1To80LIyYOoS6QLsYeG0YVbnDyLdiZEaZjYRvzD3aQj17+FZYGLZpjb4d
         veGrCb3YD8IRsnrEPLBgUL8WTbv4ygk8FPWQXLltlPJRKVZ5YULCMdovPDvPhXa9UuJy
         FykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719400510; x=1720005310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbQ9yTrKHIUgvEQYgg/gM8+VqeT6Z6yVUnnBdLfHz5Q=;
        b=ipc775PkmCYF2y2d/nuN80Z2ZBlqF9mm/xJT5pgYm80hHrhDQ5wWvcLy+UrypxiLw3
         jnSUgy+lC9YQDhwWNlav3UBwzoim9mMGLlJojElsVSHTKBS5xkDcn0NmkekZdvwf0Tfn
         xWVvVtiYu8zvkWLdzCglXyWkvXLpPC29tyqX3EtZNeE1gIukR6hysTk+IDKes7A/Hrov
         4hwGrG6AOCjlr1/IuSZ7epsp4oqv5Nvt2rm5c0uwwBLNTPjJcf0b1I/Y67WorpUFejPC
         kVMVUxwajIGBln9Ztu8/FuNGIjLC7UpbFP8plYrRFu8Hv9s0w93FcFV32E3Cq69Ri9nz
         2CYw==
X-Gm-Message-State: AOJu0YxhU3PWVscr/YGfhPLXwjoXx0Oohz4qTMbWa5UP/+MtSV+20TFY
	/xrK0NIlEso6/jk122/7CD/OV/QvT+jdhHpYibUBSkVh7t81PJy38htBJw==
X-Google-Smtp-Source: AGHT+IGhP8uz2yxpeoC+LNaSr3Hm2lPmI1HI7yfunlVSqtboWyeD5gxlAn5COi6XK98kcy3tHtKt6w==
X-Received: by 2002:a05:6602:6d89:b0:7eb:8d08:e9de with SMTP id ca18e2360f4ac-7f3a780464amr1445613939f.14.1719400510147;
        Wed, 26 Jun 2024 04:15:10 -0700 (PDT)
Received: from localhost.localdomain.oslab.amer.dell.com ([139.167.223.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-71893794615sm6368185a12.88.2024.06.26.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:15:09 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Subject: [PATCH 1/2] ACPI: CPPC: Replace ternary operator with max() in cppc_find_dmi_mhz
Date: Wed, 26 Jun 2024 07:14:45 -0400
Message-ID: <20240626111446.1445111-2-prabhakar.pujeri@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626111446.1445111-1-prabhakar.pujeri@gmail.com>
References: <20240626111446.1445111-1-prabhakar.pujeri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..a2591e1677f5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1837,7 +1837,7 @@ static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
 		u16 val = (u16)get_unaligned((const u16 *)
 				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
-		*mhz = val > *mhz ? val : *mhz;
+		*mhz = max(val, *mhz);
 	}
 }
 
-- 
2.45.2


