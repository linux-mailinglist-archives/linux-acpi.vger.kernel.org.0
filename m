Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC795878B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF0QrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 12:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF0QrN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jun 2019 12:47:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BCD2054F;
        Thu, 27 Jun 2019 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561654032;
        bh=4xUGv1/o6blMAKCCJJ4W4BVLGoWulRvdcHqF1JjKY2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDIpUHGYhjrQKfQtioIrtGLI5WLEzWVGVW1ZuPbuDNGK4TeZdUEWZB1k8gKj5At/8
         aXyF95c7d2u2o8zP78iql17oz8bmky8JtFX7D9HEkmM2+8cX7/SeNfyW71K7c05HZT
         IKQoQLGhlMOjPS1M838B5E/acmo7oduSjvbk1ls8=
Date:   Thu, 27 Jun 2019 17:47:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, will.deacon@arm.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, lenb@kernel.org
Subject: Re: [PATCH v5 0/4] arm64: SPE ACPI enablement
Message-ID: <20190627164706.rdmoze4we2dcshts@willie-the-truck>
References: <20190626213718.39423-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626213718.39423-1-jeremy.linton@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 26, 2019 at 04:37:14PM -0500, Jeremy Linton wrote:
> This patch series enables the Arm Statistical Profiling
> Extension (SPE) on ACPI platforms.
> 
> This is possible because ACPI 6.3 uses a previously
> reserved field in the MADT to store the SPE interrupt
> number, similarly to how the normal PMU is described.
> If a consistent valid interrupt exists across all the
> cores in the system, a platform device is registered.
> That then triggers the SPE module, which runs as normal.
> 
> We also add the ability to parse the PPTT for IDENTICAL
> cores. We then use this to sanity check the single SPE
> device we create. This creates a bit of a problem with
> respect to the specification though. The specification
> says that its legal for multiple tree's to exist in the
> PPTT. We handle this fine, but what happens in the
> case of multiple tree's is that the lack of a common
> node with IDENTICAL set forces us to assume that there
> are multiple non-IDENTICAL cores in the machine.
> 
> v4->v5: Remove error returns from arm_spe_acpi_register_device()
> 	Add some review/test tags

Cheers, I've pushed this out with the acks and typo fixes.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-next/perf

Please let me know if you spot any problems.

Will
