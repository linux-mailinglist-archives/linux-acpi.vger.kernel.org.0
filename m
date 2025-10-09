Return-Path: <linux-acpi+bounces-17671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82DBC963F
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 15:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BF7F4EF5DD
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954162E9759;
	Thu,  9 Oct 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYbfoC62"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362002E9737
	for <linux-acpi@vger.kernel.org>; Thu,  9 Oct 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018277; cv=none; b=MUBClDtUo7xzHmsnQlISXIO+d2cMXAkk52kPtAv/3YJsAL2RFfguPy5i2oTUp6+QCtspcMcySY3uq8ja+OQIi/uVy1qpmc0bmTtw/yLN5Gxkoox2g2JlDUU8pf61pwiGSNA1Ywaclwu2prGFi9puDyoc1Hza/rpX1NgAFgpQKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018277; c=relaxed/simple;
	bh=aNMJD/jvy4Eo4PisGaBxwtDDj5VIcZ742XhFZPY72NY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FxfbQz+UTwOy9oeKgeynLMCy1L3EnuKmIkX33ikW23i1NpHrv7vLrerhkN9PwjUx9TNvbRt+fhGCYrivsSJRBRfLeFiOJYeaAzG+Vx8ovgdAjBzT8SHLtoa28JvsjTwN/hLlNHVLm+LHxdZOJhzOWZ4EE5oYVtYGMD5JXXcp1qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYbfoC62; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1388840e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Oct 2025 06:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018273; x=1760623073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/MGlGn9iIYutzRbmuTIcRdh98fdrcz/bmBvtZd2PYA=;
        b=eYbfoC62WGqXp7je6bdcNN/hQhsf/sgDakDMzqCG59Mu1xl4zzmN9xZFDJ+zKPGSwH
         Lz69PC3FUDXoMFD4z6eg31mL7vHN55lAN1AoYjQVmHjzHl8sJyAGC/8Dwz4QGsn2Ybs7
         ILEJSYkNzA9sbwEf1BYH3JKeLdH0d3qCDWgno1zC8GeKVnT/3tLAcCNMI0/c47UKVwtw
         8LVlxQWlTUmVURPxmhT8/WYXS0Ld+z3tlSvRPzPCgCk5369kewJn7vN5XNYEjt6e0NRd
         YjrmV1i0vVy3QozpnGFo4HfZ7LxIAeWlFk0qazfZ/0HGekauil7ujd6KNRmBj/yyohUk
         z5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018273; x=1760623073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/MGlGn9iIYutzRbmuTIcRdh98fdrcz/bmBvtZd2PYA=;
        b=jXILwERHhI+L6uu518GgTr/yKcLwQuc/BXqC8/UFE5xw1OQHQ4ta/GiCiljctJOL7i
         7MLva4Jz0aVf0Sa1e0vyIMLDZ1Jquez3HwQmhOXL77KXmLjLysI0/2P0OICmPu77GplV
         UaHv0yaJR275Gj9BbDpohalGcY4o5aS4KuuvgIZolATTq99tjNjEGiwehZZnkuorHYaQ
         65JK7ALEYkeJ0t7zFeGX+45UXGLGuhjfzDeMfxb/Gtx3EdSA/rj9+q1qpvw7UTmxQFWA
         r7LMVWxyvTFX8NsER3LSNywxaRB62W65w3EVgvKUo76EhMAXZno/vAdED61f45aXoYBp
         hhcw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Tkt6OCTw3m8DtszaJ0sXlVsHSkmNh2R575eBS7dbdrSzX2eARSTCPPXzijFHGWDNzomLIF6Us7iL@vger.kernel.org
X-Gm-Message-State: AOJu0YyPp8uKEocjMJapMNWIMG+hbJNstlEm98faEmmRTtU1vSaKsUDA
	EbYwyl84zt1moURWm4t5kKaByrzQn+HYs3b4T3Uw4do69aQrNx2uCJZm
X-Gm-Gg: ASbGncsPICQWZVrPoimSKNqLhGmiulyP5auFU9YbORY9ZYgsNKZg+2/GfPGIA2lcH96
	WaYcPcsUhIYMETbyj5i8+7XeTGS/dFtT1P1YHnfk2betuy0kCPS9NpFofSRGxGdlUkMdaZfS0hy
	w1nrUzxmfKH9CWmFlbqgkcOZk8iqcuqu8cgTg7VD8QX8JQA6AdDKfY1+Xj0MeLuZ5YWppdnNGCI
	MGVoPPbuO74ouIVXZ58ujavejSWV4HgcOeZMm6OCVOL036m60inGGkBjq6XTe3fhbI5i6ewyetz
	/pO7qX35uJB9ylTm40wi+RmbQzzQVsQH/Ldg+gBzsx1wA0gIMKlu3hyVWTtPrvjbXu8zTwwiaVp
	ceJYR4lGpScfEDhIEs07LOU4/RA2wJqKYpmOrwr5WdjEPOJf2LQvo
X-Google-Smtp-Source: AGHT+IHA8m/U23aYo0HxP+3yhD2Pn0UWeadCQA7OeCHX4f0bCNRxiynEaIMEXCIiEdfg2ltvNFQ3lQ==
X-Received: by 2002:a05:6512:3a90:b0:58b:75:8fc6 with SMTP id 2adb3069b0e04-5905e28ba56mr3556064e87.19.1760018273097;
        Thu, 09 Oct 2025 06:57:53 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e55esm1066082e87.78.2025.10.09.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:57:52 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ACPI: Add absent field_obj null check
Date: Thu,  9 Oct 2025 16:56:47 +0300
Message-Id: <20251009135646.8899-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_ev_address_space_dispatch function is designed
in such way that assignning field_obj to NULL is valid case.

Cover the missed execution path with this check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/acpi/acpica/evregion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index fa3475da7ea9..fa01bcd3840d 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -163,7 +163,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
-		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (field_obj && region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
 			struct acpi_pcc_info *ctx =
 			    handler_desc->address_space.context;
 
-- 
2.34.1

Just FYI, this patch was already merged to github ACPICA repository.
Commit hash with correspond changes at ACPICA repository: f421dd9dd897dfd1e0c015afa90cd0de2464e23c

