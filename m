Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB820C0FA
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Jun 2020 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgF0LIj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Jun 2020 07:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgF0LIZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Jun 2020 07:08:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12A621531;
        Sat, 27 Jun 2020 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593256105;
        bh=CKFRZQvVXoQGRUt/fr1evMIOtF/D2G3jbib+jYbyxlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGldGMH4GnVEZJM9lKrAO4vuHndpGt+hjl6cH5CtcHpuSHOS89YEYTeMdXj+1PQKX
         IpFUxwH79KoWlnNgFGOfWbPavxAZkbyeSsGtIo3zhpECkuamaVI9UYUJyQ3WNJjsiF
         4keML4Szu08xHn+uJV7hdRQ1XL2Ht1/vYL+oTEMY=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jp8h5-006s0z-9t; Sat, 27 Jun 2020 12:08:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oscar Carter <oscar.carter@gmx.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Andrew Perepech <andrew.perepech@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 0/3] drivers/acpi: Remove function callback casts
Date:   Sat, 27 Jun 2020 12:08:05 +0100
Message-Id: <159325548742.93134.13767620418777913420.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200530143430.5203-1-oscar.carter@gmx.com>
References: <20200530143430.5203-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, matthias.bgg@gmail.com, brgl@bgdev.pl, tglx@linutronix.de, oscar.carter@gmx.com, keescook@chromium.org, rjw@rjwysocki.net, lenb@kernel.org, andrew.perepech@mediatek.com, linux-mediatek@lists.infradead.org, stephane.leprovost@mediatek.com, linux-arm-kernel@lists.infradead.org, pedro.tsai@mediatek.com, bgolaszewski@baylibre.com, fparent@baylibre.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 30 May 2020 16:34:27 +0200, Oscar Carter wrote:
> In an effort to enable -Wcast-function-type in the top-level Makefile to
> support Control Flow Integrity builds, there are the need to remove all
> the function callback casts in the acpi driver.
> 
> The first patch creates a macro called ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
> to initialize the acpi_probe_entry struct using the probe_subtbl field
> instead of the probe_table field to avoid function cast mismatches.
> 
> [...]

Applied to irq/irqchip-5.9:

[1/3] drivers/acpi: Add new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
      commit: 89778093d38d547cd80f6097659d1cf1c2dd4d9d
[2/3] drivers/irqchip: Use new macro ACPI_DECLARE_SUBTABLE_PROBE_ENTRY
      commit: aba3c7ed3fcf74524b7072615028827d5e5750d7
[3/3] drivers/acpi: Remove function cast
      commit: 8ebf642f3d809b59f57d0d408189a2218294e269

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

