Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BBB2D78A9
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbgLKPDF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 10:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437564AbgLKPCe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Dec 2020 10:02:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C7E21919;
        Fri, 11 Dec 2020 15:01:52 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knjvb-000TxV-7I; Fri, 11 Dec 2020 15:01:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com,
        mark.rutland@arm.com, zhiqiang.hou@nxp.com,
        Biwen Li <biwen.li@oss.nxp.com>, robh+dt@kernel.org,
        tglx@linutronix.de, lenb@kernel.org,
        John Garry <john.garry@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com, rjw@rjwysocki.net, gregkh@linuxfoundation.org
Cc:     xiaobo.xie@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@nxp.com>, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org, dwagner@suse.de,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Support managed interrupts for platform devices
Date:   Fri, 11 Dec 2020 15:01:36 +0000
Message-Id: <160769813659.482133.15424390769079423897.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: shawnguo@kernel.org, linux@rasmusvillemoes.dk, leoyang.li@nxp.com, mark.rutland@arm.com, zhiqiang.hou@nxp.com, biwen.li@oss.nxp.com, robh+dt@kernel.org, tglx@linutronix.de, lenb@kernel.org, john.garry@huawei.com, martin.petersen@oracle.com, jejb@linux.ibm.com, rjw@rjwysocki.net, gregkh@linuxfoundation.org, xiaobo.xie@nxp.com, Zhiqiang.Hou@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, biwen.li@nxp.com, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, linuxarm@huawei.com, linux-scsi@vger.kernel.org, dwagner@suse.de, linux-acpi@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2 Dec 2020 18:36:52 +0800, John Garry wrote:
> So far, managed interrupts are only used for PCI MSIs. This series adds
> platform device support for managed interrupts. Initially this topic was
> discussed at [0].
> 
> The method to enable managed interrupts is to allocate a group of IRQs for
> the device, and then switch the interrupts to managed - this is done
> through new function irq_update_affinity_desc().
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/5] genirq/affinity: Add irq_update_affinity_desc()
      commit: 1d3aec89286254487df7641c30f1b14ad1d127a5
[2/5] resource: Add irqresource_disabled()
      commit: 9806731db684a475ade1e95d166089b9edbd9da3
[3/5] ACPI: Drop acpi_dev_irqresource_disabled()
      commit: 1c3f69b4543af0aad514c127298e5ea40392575d
[4/5] Driver core: platform: Add devm_platform_get_irqs_affinity()
      commit: e15f2fa959f2cce8a05e8e3a596e75d068cd42c5

Please route patch 5 via the SCSI tree when possible.

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


