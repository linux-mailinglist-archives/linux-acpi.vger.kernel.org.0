Return-Path: <linux-acpi+bounces-14974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A9AF7469
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 14:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635FD1C421C2
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 12:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46792E3B1E;
	Thu,  3 Jul 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfCuwHOn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FF2E5400
	for <linux-acpi@vger.kernel.org>; Thu,  3 Jul 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546549; cv=none; b=cq//sOr6GuEpNOaxo2SwPULe8sgExvxXiXP06jvPC13ZGqKkYn8iILL5jM9vDkyi7PyEQeEX6GiLzu5MoMztkakM25bcjGQ9e6sjw42kxTuUEbXyleh7Q5NvNfkQUBuXHejS0lHFjvfLULY1KMAKjiqqbUlC33K/NQM2rd3FpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546549; c=relaxed/simple;
	bh=N7vLc0oqLmYrsKimgv5aPGLXrXUvS+KvfduP2VAQNUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWsDKMmt4U8+Nnd3v2WGmMIHdgVlKbHfv68FwyK2/I04bLauV/8ku3YKLO+4Dd2L3jez/3xJi+zVeoZSBrjHh71/qj3LJ7fn7aayxtnx3t//kytP73nn7GRIqylfix6uMPCUvf7jWoxS9OcGhysTZw/yQHO7ZGjUf9uVpeA/97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfCuwHOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751546546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GrhGjJGChgvyGST3XK03qsYwL/VV6VbNHViMoMb02Ss=;
	b=EfCuwHOnT6XoDFiTIfVSG5cZ/dTDoQ9kwmMHAz8G0KRxU4s0FXWcE6tznreLaz0o4scwy7
	V0FQPDAPB5h2Cz9ll6CN9th3j8owtarU8plug1t5YZC2Kh62JGDG7k+yUQQ53wzEqP5Zry
	2RzqfFkDfj27iwy/E5kd7uLWY7RI3kw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-NZNfWGU9NZO_6WfGxkUEFw-1; Thu, 03 Jul 2025 08:42:25 -0400
X-MC-Unique: NZNfWGU9NZO_6WfGxkUEFw-1
X-Mimecast-MFC-AGG-ID: NZNfWGU9NZO_6WfGxkUEFw_1751546544
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a52bfda108so3827263f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jul 2025 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751546544; x=1752151344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrhGjJGChgvyGST3XK03qsYwL/VV6VbNHViMoMb02Ss=;
        b=FqJwsEacgY9YUZO5mPhBjUvQ+nzzCTICLIMAvnibpdFr6ufU5Iugcwd7JDb1nCTvSP
         NKGVqbjizmixBqTxLC7ynMVZaVHhlDuEAu8Yp/+wgzeRnNcFRFMohSJcwzBCHBpbvriN
         rhHlvmMjiAQTewlmmSY9BfX+KbFansRlhQTcH7dfidmVh9Zo/jSEU55yJ0lSLb5JyAkw
         8C6QPG7QNw0JABwDevdJIVv5rjkJptU6RQm7mqH/GkqLe66kASmGfbSEIpbJJOucpAHj
         V8RT/HMfL4GBtT4uakV8Qxruckm+bDcyj+klclBVgSc35IOakNB9yckoem7kwcRQ2HH9
         LYmA==
X-Gm-Message-State: AOJu0YxMhOj5UecslgTKVqCNPgzonEk8NQQJdSTrXZAygWSEjNPbCAvC
	XEKmRdCN1YD3bgy+bwya6o2HSgHQLqjRvS+Z0nvUSHaQuNIhqXtCynrjeK6cljGf2Gkg6wRvmkF
	gtwy71gk8+RuLSlCWnOVRNDcSILCLoucfmWFZim+hb23Nh4kAB+V8WN57vqW8F35tQYljoGA=
X-Gm-Gg: ASbGncvR8ZcJHPYZ1GmeCJA/MWW4TP1N1Qzuy56jmyQMeeHTsQw1itJRB+eoKaFLAWD
	RyPZP1TLmT3qfq8K7UjAyDxz+hkEwoLsK6JEPI0UemouPwqnsBlZv6I2C+Yq+BxNmrGqRC/Myxc
	dfXKB1IXRqwcRKIGINutDfXNh4/c0cLLkTTSiTIPzUwxFzZH1a8bCSEDmZORXQI55AiYDUFFP1v
	jFH8f+R65EdAkfQBeIdc+zs/ed6XVkiQYCz5yU7U5mA10ErPTeVH3VTc9QQXUqaMTP2mvjQiIM4
	BLfO28cNuF/Ev36gOaeGat+iN1Qjpz0LC/PmgBpfGWZpT8RZ+jBeCZhmmfX1LRlh7NWw6pjhNkZ
	9zg63dpiP
X-Received: by 2002:a05:6000:23c8:b0:3a5:2ed2:118e with SMTP id ffacd0b85a97d-3b32c56e028mr1862346f8f.9.1751546544131;
        Thu, 03 Jul 2025 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGKF27IryF4nLaw/mmC8T58sLstUYF65xX0zcwluxL2FD7cUu4oHOdykSBFHXSnS2cVC9xlQ==
X-Received: by 2002:a05:6000:23c8:b0:3a5:2ed2:118e with SMTP id ffacd0b85a97d-3b32c56e028mr1862319f8f.9.1751546543604;
        Thu, 03 Jul 2025 05:42:23 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99a3b81sm25365195e9.26.2025.07.03.05.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:42:23 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH] ACPI: processor: fix acpi_object initialization
Date: Thu,  3 Jul 2025 14:42:15 +0200
Message-ID: <20250703124215.12522-1-sebott@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialization of the local acpi_object in acpi_processor_get_info()
only sets the first 4 bytes to zero and is thus incomplete. This is
indicated by messages like:
	acpi ACPI0007:be: Invalid PBLK length [166288104]

Fix this by initializing all 16 bytes of the processor member of that
union.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/acpi/acpi_processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7cf6101cb4c7..2a99f5eb6962 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -275,7 +275,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr,
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object = { .processor = { 0 } };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
-- 
2.50.0


