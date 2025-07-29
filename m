Return-Path: <linux-acpi+bounces-15409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EEB14E3B
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44713B0FFB
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF217A2EA;
	Tue, 29 Jul 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bi4oRcMx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707F2F24
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794952; cv=none; b=n6uHOMgk9k87VOFKWD9UGAfys9s3Kft9E8XgMqyLuAkM4DMUI2cqBpaK8W4bW3ARwhduBseV7q+UfS/rMHe7gLHHqPp3ODPcAs2vMev9xb5CHMoSPCjX3IwYURQkXv9EbMoLNaWKt3GZdz9U1wZ8ObJXv7oMqAGzRPNJeYPKcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794952; c=relaxed/simple;
	bh=4hevu+mkIo+ZyFTkMUsbQzGJiy8lshyYA23UrQl0XYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaogAUZzrzxOJO0eDtb9pRew4r+8IZJtXOUps7wfKeN1iErJQPH3sCe0sZRsxPCHUw6S2E5lmSg0sZs+kDw16jymBr0E1m5VoVF57znuz+oSm8WQg04NMqn4AdbS1LNGBBYs59ddCS8ti1t7yk7leSe9OQkSoYr5HG3eUFm+jQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bi4oRcMx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3C1DA3F489
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1753794941;
	bh=uny/SuoHIBoMNtC0T+beSanQb5XxCkus1H23LWxlO6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=bi4oRcMxPw+o6RXEDhnuPecaTCXkrWU0Bxm7W9qsowk2Tls+mYL31Lb9cBGX4PR2l
	 jRGsv+W0AQwG9Xxvm3GiwkM1K3VO/7+B1X4eJ3FhPar85J8bvqU6mheOsiu8Y3mcfh
	 XaPbhdodZK8XCYtbWE/vbZkyvSFvtAKzJCDHykPZMthRcOxqL21PHf2z8fJ7f+RQEF
	 z9T1dZyPRenaSrtdoPd3/EykG+v9YLDF6VlbmUhBhwhok4kHOe0kvVaPs2P7wq45N8
	 oobXNLhnhtl8AKV8lWNgt6Q88sul5ahpSF0cqxRxtcXhD6KzZlI21dmm1uqAHXkDh8
	 +jq3OOxg07ZPw==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561dbbcc7eso17074205e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2025 06:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794941; x=1754399741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uny/SuoHIBoMNtC0T+beSanQb5XxCkus1H23LWxlO6U=;
        b=BgH1ZWcVEYDye6teHpozab7mCD45dIbh6ZaZB4ZFfdPMHhVhdUw1PdJ+8+eLRIf6b/
         eYop3p43XqzxcsN+6NBBjzaMd1SkYMlN8bkdR0jLq4bBZYR0Cyzof1mkTuK7nf7f8AmR
         mb4H9E+GdSsX+EOaQOddXDY99WoBNXXcHDmvVgyfMtou/LcFijAq2gGyu7I7bMav8tX3
         kSgwZFXUcuec4DG/QWtM4yi0WDCCT3CPSE7ZNtCW0AP164gFn5Q9S07DdLIaSpREnAC5
         Ri3o7vdF2k1ot1VWhHPxS6vsI9ZUZ4mbOmjTNR8F4KyWgKwku1obPwvnAJWx/5jt47kp
         t3KA==
X-Forwarded-Encrypted: i=1; AJvYcCV25yzjnrckgrX3kxjKgsPHDYO3yXijtJ4/0kUj/N9pcVJapR2zzlcct7yk6mkPQncFCDdo3fIhPZ2h@vger.kernel.org
X-Gm-Message-State: AOJu0YyCk6cvGo+2hliNIBO1gO/BPhJgz/ETPez18BkB+6dqjCc5lK3Y
	0rlZ7dSKMmks3MIZGuYYlu7T4gacPcapKpKvmP60xFoXmpZLrFzD+eJ2mXm0+IyEKCsIERJVRk2
	KaL1FaSCD2PH3ppIW0MKgQQLIVR0AZFOW1ww88/v6AFs7XMXWcfeWjOke+d18+PX44zg9i1oCWL
	POgGs=
X-Gm-Gg: ASbGnctTz+tKHFXt4wr1aYlnxT7XV3W6SJyEyjQqQc5g6V4MKIFuN8GKwTmhEWOa02b
	yBMwmTJDupSEaS8ovqHyArb5TdXDWhR3yWFQxfygTv/GhvQ73D5lnq2dLf7WIcYDQCaoLdyjmvu
	ECY/DrEoK6w/QJl1/1Mo8Kv34ttAkNBNBW3GiCm5QLljPY1sd4DiHYbG/uesU0GzjdL+/62jKHK
	vii9CWgRGU8hNWv1dwaIwl92ehYkjpW3VsIceVHisjcApeaj45+E33UdXhrJrGAwWcmog9tnovF
	T1AEtNZ1Yfy268GvfX4IKDsrYDU5B+xlBJRtxvsOk45H9i8xUrLU3wSmvwrFGgWW9CEwF0ivKQO
	iJyVDz3ETNoDVp+Xrc9JvvS8A78Ljbg==
X-Received: by 2002:a05:600c:1d1e:b0:456:11a6:a511 with SMTP id 5b1f17b1804b1-4587643e9a5mr124000325e9.20.1753794940670;
        Tue, 29 Jul 2025 06:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFGFwVBVYLuvqEixHBxqvK7UIN3R4LE5ewPV8saNCAcqdz9QJsAsp8Vk+uifuz7LBLpE6WuA==
X-Received: by 2002:a05:600c:1d1e:b0:456:11a6:a511 with SMTP id 5b1f17b1804b1-4587643e9a5mr124000125e9.20.1753794940339;
        Tue, 29 Jul 2025 06:15:40 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9bdfsm12024338f8f.20.2025.07.29.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:15:39 -0700 (PDT)
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
Subject: [PATCH 0/2] ACPI: support BGRT table on RISC-V
Date: Tue, 29 Jul 2025 15:15:33 +0200
Message-ID: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.0
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

Heinrich Schuchardt (2):
  RISC-V: ACPI: enable parsing the BGRT table
  ACPI: support BGRT table on RISC-V

 arch/riscv/kernel/acpi.c | 3 +++
 drivers/acpi/Kconfig     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.50.0


