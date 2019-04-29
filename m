Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 757D3E35C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 15:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfD2NMO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 09:12:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34132 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2NMN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 09:12:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16so13570509wrp.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FdyeOJZ2ex4Zc6ZUlDkL19h7wiPhcsY/XH7KMsWAxQ=;
        b=HgNtv9S47DA4Fn0yj6/I2EWI/tgw5TVQmj2ZvENRrg2Q6D5I22lEwiJ+nvfE15WAHX
         BKzEHpCrIygb9USpVb4rR6tOhdcVkmUrPCtKfk06/JxFdlzOVZp0b2aDnaKp0EUSsQ2q
         o3t9vbzy9vllw96TCcZBrsAYMYPgzp5bxWqhROtLh0PzsJ74+zEAVdF4uawzeViM65Af
         C6VLivUFXfwqFVhGFisRqiWzUqtn3tQMA11lBtQjvGUX2RUMWwYniJ6A7iCTTvm00UNg
         HppRgTsgLxzJZdTIGVna3AYMeFd8TWV6Oh3PCkCnbnZcgnvD+11A4FF1NRkY478Zb3/1
         c7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FdyeOJZ2ex4Zc6ZUlDkL19h7wiPhcsY/XH7KMsWAxQ=;
        b=fJzB3I0DGQEhKcRYW/tS5+z5qDe5vFqZ6zWMZ6F7AFlBfSE3/qXq1NWfHDLS/Uz5GH
         Q/p18ljRY7pAGXAD+YEcH8/fgg+GCoqX0U2SbDw78S1VsLVwt2thAj/EVPgK0vCdcO9i
         aooqUF5sC5w+edizGQ2I4ayXuAyoORF+JdnQEjEmDNJvCAqAa54/yspNKzlb/sO1ontN
         nd0aMIapAC0ju2xDkX1aBhgrukz/Pau9Av673KHcQLQW+xLeWb0vAD0aPyefYa98Nd5Q
         BmZIiUeh/ytkHZ4pKHJXbQEEhk8g8zAVMu4eoaLLoCiZ2jVEafFK77CXIj4vwDOy2Szs
         qVFg==
X-Gm-Message-State: APjAAAXxLkBaq7iXElNLdOlZqPJENgi0mBdRbyys1RCttFF0CTxBdY+D
        KxDjHaiab6eDJznGz8NgCfex0w==
X-Google-Smtp-Source: APXvYqyNyKPUk3RMZvucVYLDyIAejSOjYUUI55d5btNbFVE5w9HCcH1t4jUqsOLBUsU+oE8U7O6zcQ==
X-Received: by 2002:a5d:4fc3:: with SMTP id h3mr29334wrw.54.1556543531886;
        Mon, 29 Apr 2019 06:12:11 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f9fc:88:6502:8fa7])
        by smtp.gmail.com with ESMTPSA id s16sm5410282wrg.71.2019.04.29.06.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:12:10 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 0/4] synquacer: implement ACPI gpio/interrupt support
Date:   Mon, 29 Apr 2019 15:12:04 +0200
Message-Id: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Wire up the existing GPIO and interrupt controller drivers to the ACPI
subsystem so they can be used on ACPI systems for ACPI event (power
button, hardware error notification etc)

Changes since v1:
- Describe the EXIU controller as a separate device, which is a more accurate
  depiction of reality, and untangles the code a bit as well. Note that this
  requires the GPIO AML device to describe the EXIU interrupts explicitly.
- Add a patch to obtain the ACPI GSI irqdomain. The EXIU driver needs this
  to obtain the default parent domain, since the GIC is not modeled as an
  ACPI object in the namespace, and so the parent<->child link cannot be
  expressed in AML.
- Drop the Kconfig symbol for the GPIO controller. Just include the ACPI part
  when CONFIG_ACPI is defined.

Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>

Ard Biesheuvel (4):
  acpi/irq: implement getter for GSI irqdomain
  irqchip/exiu: preparatory refactor for ACPI support
  irqchip/exiu: implement ACPI support
  gpio: mb86s7x: enable ACPI support

 drivers/acpi/irq.c             |  14 +-
 drivers/gpio/gpio-mb86s7x.c    |  57 ++++++--
 drivers/irqchip/irq-sni-exiu.c | 147 +++++++++++++++-----
 include/linux/acpi.h           |   1 +
 4 files changed, 170 insertions(+), 49 deletions(-)

-- 
2.20.1

