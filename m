Return-Path: <linux-acpi+bounces-4875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47498A086B
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Apr 2024 08:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1270A1C236CB
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Apr 2024 06:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C013CABF;
	Thu, 11 Apr 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rc+mBbEW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD913C822
	for <linux-acpi@vger.kernel.org>; Thu, 11 Apr 2024 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816695; cv=none; b=nBZU1baeDqVj/XyOSWPc/s8PxXnO4NvClEJynkIUdzFka6aWciRbbxIYHMj991VGh6ao51CXJNf5r3aypfLYvyWhq/kB69sFCEwZnEjh6AtGNmIhvSuqg3yARpHrxIfZx2wiMKIYI7m0KFxLraxHshyDX+UAWxYdUwAJDjyxhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816695; c=relaxed/simple;
	bh=444uiMQcMJzHmI0zrEsPgMSi/MBOOaGCll154shiDkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EprzoyK733eEBjZU8WqymKst/X7J3phRCHtDScDbIoXk5Uhy1uCbuAxSFZsfr6p3SR85aA0VxhMme9lN8n7iNiA63xGom+i0/F3Sntg011m3GO1gI536s7GuAb4qJ8gWYKScO0nZmkxvUFP2yZFkJnbL0rzFU6HyF1pGaw4ULDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rc+mBbEW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712816692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RCX6MGp3mzAjan9U+6PijABpgY0GU571g8JyE/O/vz8=;
	b=Rc+mBbEWEdrWlY7EZXv5Vi7r7y/W1QYbOJnCxRShUJBTiZVAOpyXCno1qdgKGMhwCahAWD
	u7dKsdvQPM7PfrD/Yly7SK3fvXAvhAgioUO2U6y0qo/k8usHlJ/kp+nxFocCn9ALJ11cmN
	WK3KADNyfYDUtL7SczMjeZWHG5ITjPA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-VhK31n7oNwW-iuW1ykGjsA-1; Thu, 11 Apr 2024 02:24:49 -0400
X-MC-Unique: VhK31n7oNwW-iuW1ykGjsA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51f7f1f5dfso52006866b.0
        for <linux-acpi@vger.kernel.org>; Wed, 10 Apr 2024 23:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816688; x=1713421488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCX6MGp3mzAjan9U+6PijABpgY0GU571g8JyE/O/vz8=;
        b=aAHzF/xr07XidQyTdjQjOms7LO+QoecjeClMy366MDXynggSgOPEzwstGudnza1JO7
         grQRaKcXrB4VLv1qJoOc4RsZ3mpJUtPQ/8B2DzUBHK6uHwAxsPtgBQhYJDyfVymB1ZRy
         hu6DwY5j9FRnxzA6NQ9eoSH49Rhen7ZDH3kSVK/c9IUUnRtfHGrz+9r5sVz7AQOmXc5m
         7isLOjml53ar5I5JMTpx11wX63emXH7gxr6TRStiFCxjGt5dVb7gkvdOPghiPx0PBxCS
         yqMKmSgKhZJfAQW1P1ZyRDs68U0h/MHQxsrWFLiNdXOiuJ/UjzUsnaOZcddmYzXY8hbt
         77wg==
X-Forwarded-Encrypted: i=1; AJvYcCUJSDKgl0fJi1NAY5qi8y+0tlt80ph/0Ry1JHOL4085siJnc+bDfX1lpaxmU+3o6XVuLrjzXNX1S07p8oLaMfPA/z5K71hvNdOVlQ==
X-Gm-Message-State: AOJu0YylP297ClAMhK8d3Jp7qPfK3R3xoGx3pgy1fENg/i9TzmwfTGZZ
	i1ecK9ABbb/NXugdNzkYglcrAHyGOfkTcCPl8fXw3BZqyQwuvtnINKr9ql7Sro8tevUbSIOJOZ8
	ltrBwhNlDdxIrrFzIq28WMFoyXX0h/VgqHjrdRGb5G+Yv3UNgq2oHdd25Zv0=
X-Received: by 2002:a50:a69b:0:b0:56d:eef4:28f0 with SMTP id e27-20020a50a69b000000b0056deef428f0mr3980164edc.20.1712816688790;
        Wed, 10 Apr 2024 23:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVcBcnrTAav1zdTHrQ+F/XWt8yZqNhgddppdiT7mQ7vHwUi/Ryaz0cR396KTlvaukyg8GrQ==
X-Received: by 2002:a50:a69b:0:b0:56d:eef4:28f0 with SMTP id e27-20020a50a69b000000b0056deef428f0mr3980147edc.20.1712816688397;
        Wed, 10 Apr 2024 23:24:48 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id z21-20020a05640235d500b0056e718795f8sm379123edc.36.2024.04.10.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:24:47 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in COMPUTE EXPRESS LINK
Date: Thu, 11 Apr 2024 08:24:43 +0200
Message-ID: <20240411062443.47372-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 12fb28ea6b1c ("EINJ: Add CXL error type support") adds the header
file include/linux/einj-cxl.h, but then adds a file entry with cxl-einj.h
(note the swapping of words) to the COMPUTE EXPRESS LINK (CXL) section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair the file entry in COMPUTE EXPRESS LINK (CXL).

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index edf6176a5530..03204db05027 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5415,7 +5415,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
-F:	include/linux/cxl-einj.h
+F:	include/linux/einj-cxl.h
 F:	include/linux/cxl-event.h
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
-- 
2.44.0


