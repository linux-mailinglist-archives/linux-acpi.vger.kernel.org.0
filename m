Return-Path: <linux-acpi+bounces-15411-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3853B14E3D
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8273B1BB8
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24F1ACEDD;
	Tue, 29 Jul 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DoAZmCtE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F728DD0
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794953; cv=none; b=OAMpSMYKkVUjp/Z8HXyS2iQ9II1hxdZ4Eaig+cnhw8oBH99CvpzjUYmDCPkO/vOqUb+9N4ba4NMWqOC6d4tYkHapD1LdiImKtaIg9SUVi9IPACJOWdw0QiIj0y1iax0PFRdiKtrbsrqBwEf4VTHmuqWy0m2rMgH1cf2J3eLRgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794953; c=relaxed/simple;
	bh=WEEFRuZ4+ENMJ7YVkC0nl3+667eJGXsp+eQnRs0AYRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB8s7icrDK1rMUxGErFUI1tQzkzXldM09xgo3Ncaa+oGzZZp4AJY6UCRAZX51C7z4DXki/YIpJyBJ/3hyHRGvjZf5fhspRpS7tYthCemPnpAowSTxYbIGMTge/REfbbfDWiDFvWkHKeVQc/83d6wgLSqj5M7oTykgWZTcPqbXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DoAZmCtE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CCFA3F29B
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753794943;
	bh=8mHLBuTzC98LIzgNpd9Kf1f74WAo1lI4NdQKyG/FFBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=DoAZmCtE+6kdJ/uQXkyx3JFPPnfo+KXfeujA8TvFhAA00jcAB9qR3x7wD9YL5FJ9+
	 ep7aQQTVG1kct6g56UX6sLDk4B3pcr2SJov2Zw88l63aWNNisw2Ec/8D+JlblnT7Ce
	 3agQw8eKYUgqboF6JIftVCRLBeXyqDR2qK0MPWCIjwBtVBMlHFqNOltbfbntANFovw
	 Q7v5AJezcVHNhgqEkkjjS8nqrOAHhvXYkjFssNPUSIJ6ojTvHkDVzcGDrviKCT+HLM
	 dQGbn1QlgnQ69wqlmivWGp5bXlMZGzpK2RMeusO2pvS+m4bX1PjCtFXBKJXVLhR4rh
	 THmNMwqHCCXbA==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so23575225e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 06:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794943; x=1754399743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mHLBuTzC98LIzgNpd9Kf1f74WAo1lI4NdQKyG/FFBE=;
        b=EJGdVENrPQ5OZrO6t0zY8DaoCam1+HkuCF/TFdz2kILZ0ojiC82ogXHCWn5kBvEpHH
         hQ9E/6mfJX3Ww1DKq0MKH5zrJbJniK3qLu4LYWU0DOeNR0b6w2XJfUyf2cCF5Pojalyy
         LWdXaEJukyiSblfM18LxPP+D9pUuAHa0mKWrPv1eNibVVnsbNOB0bipjgaWMUrOFGGue
         BhOtLu+VWQ4Rqaydx+LBwD3G6rswo8j0DWwsyo0T7jaY3vpe/RMPUUjmmhWjtTd0Q9dT
         rF0/pRXOiTkYngFPUSR6L17uSeu9pF7O7Do6gVQ4VxYtoNtUccpXJtZ8mksdx7raSABr
         H4ig==
X-Forwarded-Encrypted: i=1; AJvYcCXaDvFZtiy3Hk3xoO349VRtNsQRFAQ9cdut7QLyf36c5Sq8a2rtDvlunTf5H4vzbZMdXek/49A7BABT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//BVqrFLTM/agShNsjixYu2U/XR4Rjxg7i52waijl5PvlqMeq
	m97A1nXa2AKE4AEKvKTicc6TbcJQlQNRAsfLNmg4Bm5yYu/L6KqaPdRdfjdR5w04zIP75oTqTHG
	ok+S9TSZCG8rMrsGa9/BGXrJVQUeISF0KWE3EoWzV3RxDuq9EDSXCDg3dvTOxQkKqqp1aFO6YCo
	uZ/vA=
X-Gm-Gg: ASbGncspRV8JqnrYbd07XjZzbRaWVkTCyy6hQ2xvH9xlM1VxC3BPeBfO5NmoUwV2FOs
	XYlrArane3kya+UPBe/oev8qGiCm4UQR4DqzeOZ4H6/o89Z2EQQLUD7R0g576gq2Ljjdt5JyiaE
	oX7wxSmuNYzjISAW6LP+XCNEqVyVlA1lmoVZP4Ui3Ierx2TC4fFYaqEIZDwIRhXQWiSrlgcATRA
	xNuaenE5UnE2XjbUKvjKnTwoHO0K9Tf4j6chQR6Bc9CUt4ykR7/88jJpLke1njoA5UVA8zo/vPe
	BO832MvYgtOfKplnTw/vwCuOE6ojEsUD/q2XnwD4h2GtD7XGreOAS7SRr2ZBWNpDkBXjBEQOEGM
	QlLLde3l/4tZYzYBGG3RmFEriJY4vXA==
X-Received: by 2002:a05:600c:358d:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-458827c18a4mr74278565e9.20.1753794943010;
        Tue, 29 Jul 2025 06:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFEgKXSP/cqBIEsBU5ORHg/b6zfhpLYR1Wb0W3l+PyFvCX+IqPWXeYXBbojnUcAC31L/JA5g==
X-Received: by 2002:a05:600c:358d:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-458827c18a4mr74278385e9.20.1753794942609;
        Tue, 29 Jul 2025 06:15:42 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9bdfsm12024338f8f.20.2025.07.29.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:15:42 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-riscv@lists.infradead.org,
	kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] ACPI: support BGRT table on RISC-V
Date: Tue, 29 Jul 2025 15:15:35 +0200
Message-ID: <20250729131535.522205-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BGRT table is used to display a vendor logo in the boot process.
There is no good reason why RISC-V should not support it.

Remove the architecture constraint.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7bc40c2735ac0..2b83c91bb1a78 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -460,7 +460,7 @@ config ACPI_HED
 
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
-	depends on EFI && (X86 || ARM64 || LOONGARCH)
+	depends on EFI
 	help
 	  This driver adds support for exposing the ACPI Boottime Graphics
 	  Resource Table, which allows the operating system to obtain
-- 
2.50.0


