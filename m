Return-Path: <linux-acpi+bounces-4477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A482E88D78C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 08:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3621F29838
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684F2C6A7;
	Wed, 27 Mar 2024 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdBvHhiu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA22C68E
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525484; cv=none; b=nJxL+SfiIVmJMwzoueUNA5Uv6S6t/5jc/MJbkJOYz5GoohgQ4VZInLBc049DoInwkccmWUcoOqvWoyiSFzvOs1LN+FICSiPtOYrxEl0OhXQ1yHDZTqcf1RJG62fJtw5UO4ClZl6omyDiPh8veD8TD1mFVio5ytV1wHS0nB2IUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525484; c=relaxed/simple;
	bh=meBEX830gRW4HXcwRaI98fQKaU/0vg8wDYKxDADJaXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EH+s950bN8W3Z2DoTNOLFVJsMcEEvpybwwJm52LJCG6fACSil8Inhl2r0nzVAEofdmAZaT3h0ktZE6sY77oUu1dLadJegLFhuaSBOJAsX7CcAeG/pRtuULEGfE1r8qdR+UX3JJ68oA7r7ybyypHWlZVP/4A8FZocQC+ZL9O3Nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdBvHhiu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso809446866b.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525480; x=1712130280; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwJgbNd9Cb1xxQGP3U28yL2PzFi4V4xZap9Ru43Q/Mw=;
        b=SdBvHhiuyUFUwk8YiTvwTtM0bHquxeOd2OPGUG8vYvWcXZnHxn1vC3JMkri5DuT2yE
         izjt00bO/nAqGy0SL8agPK3BuCqc6QXUmOA81omR5XOsCZAWY4+FubBak/OxYtnjhaOi
         S0FMQW1j/sFO41MbQXMHvg5E1Y3x+AyH+prQe5CztQWuAeX2TuSaqudsfrRLDFw8ULO6
         hD5OyKb3+NKvXLrQFbLzvXsEoLWswJC2E0e//xCD6uvBc11LNNLZTlqeNKgnxJfNReSE
         eXjh7sFj/Nwpyil4JxHw4LdEThDgguzEq8fAkBXS8io9mTMUMdbcJ611WUE/hZCi13h8
         I0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525480; x=1712130280;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwJgbNd9Cb1xxQGP3U28yL2PzFi4V4xZap9Ru43Q/Mw=;
        b=R30cGMzqVpKTAS/u0CdDxG7cb6GNAGqAfuYD/6eZq86u/sj7eDDNEvSjr2H/zhnnm6
         UP/FvP3NdsbLPU5CYzIin/yNyNWfraF3jMXfB4tIQ1vixwCME62o6kJmj3elJtduVC3u
         gyRTbEIdDtta0LTH495ppPeKtz43WoHKkW/gVAKh9Od/em5ZBL8eC6mr0IhGAgMBWrw+
         13Bb5OYEIexQgzkJC0AhLvf/9okq4AMGgvPWLw88c/l3Tr49lgejJzDEzcZuAiOjb86H
         cdGqgWh7cQ2BeOl+gbJ0X3yFmJmz56iQ1mCCjRIc/Ewb4okzNXcMlG9DzBo0MKQIvSCi
         z4MQ==
X-Gm-Message-State: AOJu0Yw7zPxvFCKq8q7y5JIjcQ7hXgoIrBawf6Sem39l3nyDsjfeXf4c
	NuKZPMIyjAGhSIb2YuUCYOQDA/k7RxfNJlToO/tr6adC7zET/SuKruviuQ0CctM=
X-Google-Smtp-Source: AGHT+IGlvH7IOquxCns2fE0YzmhHeEjVjLkRMbV5aqG3+Bvmapd6+zXlFoC0J4tu34KlhV5VJ7nhhQ==
X-Received: by 2002:a17:906:4112:b0:a46:930c:b793 with SMTP id j18-20020a170906411200b00a46930cb793mr2316193ejk.9.1711525480120;
        Wed, 27 Mar 2024 00:44:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:44:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
Date: Wed, 27 Mar 2024 08:43:47 +0100
Message-Id: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPOA2YC/x3MSQqAMAxA0atI1gY0VhyuIi6qjRrQVlocQLy7x
 eVb/P9AYC8coE0e8HxKEGcj8jSBcdF2ZhQTDZSRygqqcFC4OXOsjO6y7FGPu6BRjap1Q1SUOcR
 09zzJ/W+7/n0/4mos7mYAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=meBEX830gRW4HXcwRaI98fQKaU/0vg8wDYKxDADJaXA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85It2J1eYnVhuIuXN7MMCJqdE2fAF7WfeZ2j
 n2apL2796uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOSAAKCRDBN2bmhouD
 1/SnEACOwWo91bl9rH3s5QXO4O8oEUXK1eW8eqIErfBujjd0mBVo1U62GGVdqCTwbnohFmGH8uS
 0Hg0mT7Zeq81wweeJX6lhia/0ZXEq+ZS+N/VqqJ7A+7ylKAQBaJ/b12k4fTnfTvl8ROmcKTYwMO
 xzDw5Zk15EIcQqY7MGSWFtkoR4IrS2/djZzKQcElvc6wPnn9pAGHCnlsuqyNNfA0qKbLEKwbCZL
 ZHiY9SxWBdWl2HKHK8Mx9QC92FqorWxtdvlyyZbo8P3rLgNwOgKI/2iM2FL86OTTYm/I8h8K0uT
 4zjFkXBSfJa5ZtEMyVYWaO/zJcCvsyANCUfmn+nApiQWih+qd2Bfgz7Gha5MiT/O9rP6SsOOlUM
 tbNEj8Cj8fPjz4pTITvXtRtmnxGIMv7j1sZ7b1tn1QCd0wj9ZTUDDh5LA2Wqr/EqqxRiP7yhmJx
 VlCIdsMAP0QRviCJeFZ/5IZsqoWkmPw48k2Jj1hAr4Y6e7OhxXXvGltn8sh7mvh4j0J5zpBJlM2
 fjx/dZOndwUdkjsJSP0MbGEgMKEUw3t1Q1gKfYe6exbD7qfbc0CGKaHnss5MMzmn9bJVCGnsroA
 wySn4govEwvO62oJtu9o8OUcuu12dPLodXlbGS6LxGJSnQfhXloYUEOlIsusrAiizfR4Vy/tLG2
 szuZE69hHAS2bhA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Merging
=======
All further patches depend on the first amba patch, therefore please ack
and this should go via one tree: ACPI?

Description
===========
Modules registering driver with acpi_bus_register_driver() often forget to
set .owner field.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      ACPI: store owner from modules with acpi_bus_register_driver()
      Input: atlas: - drop owner assignment
      net: fjes: drop owner assignment
      platform: chrome: drop owner assignment
      platform: asus-laptop: drop owner assignment
      platform: classmate-laptop: drop owner assignment
      platform/x86/dell: drop owner assignment
      platform/x86/eeepc: drop owner assignment
      platform/x86/intel/rst: drop owner assignment
      platform/x86/intel/smartconnect: drop owner assignment
      platform/x86/lg-laptop: drop owner assignment
      platform/x86/sony-laptop: drop owner assignment
      platform/x86/toshiba_acpi: drop owner assignment
      platform/x86/toshiba_bluetooth: drop owner assignment
      platform/x86/toshiba_haps: drop owner assignment
      platform/x86/wireless-hotkey: drop owner assignment
      ptp: vmw: drop owner assignment
      virt: vmgenid: drop owner assignment
      ACPI: drop redundant owner from acpi_driver

 drivers/acpi/bus.c                        | 9 +++++----
 drivers/input/misc/atlas_btns.c           | 1 -
 drivers/net/fjes/fjes_main.c              | 1 -
 drivers/platform/chrome/wilco_ec/event.c  | 1 -
 drivers/platform/x86/asus-laptop.c        | 1 -
 drivers/platform/x86/classmate-laptop.c   | 5 -----
 drivers/platform/x86/dell/dell-rbtn.c     | 1 -
 drivers/platform/x86/eeepc-laptop.c       | 1 -
 drivers/platform/x86/intel/rst.c          | 1 -
 drivers/platform/x86/intel/smartconnect.c | 1 -
 drivers/platform/x86/lg-laptop.c          | 1 -
 drivers/platform/x86/sony-laptop.c        | 2 --
 drivers/platform/x86/toshiba_acpi.c       | 1 -
 drivers/platform/x86/toshiba_bluetooth.c  | 1 -
 drivers/platform/x86/toshiba_haps.c       | 1 -
 drivers/platform/x86/wireless-hotkey.c    | 1 -
 drivers/ptp/ptp_vmw.c                     | 1 -
 drivers/virt/vmgenid.c                    | 1 -
 include/acpi/acpi_bus.h                   | 8 ++++++--
 19 files changed, 11 insertions(+), 28 deletions(-)
---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240327-b4-module-owner-acpi-d4948a922351

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


