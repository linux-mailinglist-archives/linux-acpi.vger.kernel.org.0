Return-Path: <linux-acpi+bounces-253-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2A17B1C89
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 24E092831A3
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DA8BF6
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 12:35:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78160374DA
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 11:13:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CA742B9C3;
	Thu, 28 Sep 2023 04:12:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9D51FB;
	Thu, 28 Sep 2023 04:12:34 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BFE93F5A1;
	Thu, 28 Sep 2023 04:11:54 -0700 (PDT)
Date: Thu, 28 Sep 2023 12:11:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] ACPI: PCC: Add PCC shared memory region command and
 status bitfields
Message-ID: <20230928111152.cctl3m5rwtopyg2g@bogus>
References: <20230926-pcc_defines-v1-0-0f925a1658fd@arm.com>
 <20230926-pcc_defines-v1-1-0f925a1658fd@arm.com>
 <a89bdd10-9388-01f5-6a7c-894af793e1c1@huawei.com>
 <20230927135909.6rssuywmj4k3odex@bogus>
 <fbc038e3-9719-3f90-0c09-f26318e21f38@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbc038e3-9719-3f90-0c09-f26318e21f38@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 11:49:25AM +0800, lihuisong (C) wrote:
> 
> 在 2023/9/27 21:59, Sudeep Holla 写道:
> > On Wed, Sep 27, 2023 at 10:07:15AM +0800, lihuisong (C) wrote:

[...]

> > > > +/* Generic Communications Channel Shared Memory Region */
> > > > +#define PCC_SIGNATURE			0x50424300
> > > Why is this signature 0x50424300?
> > It is as per the specification.
> > 
> > > In ACPI spec, this signature is all 0x50434303.
> > No, not exactly. It is just an example.
> > The PCC signature - The signature of a subspace is computed by a bitwise-or
> > of the value 0x50434300 with the subspace ID. For example, subspace 3 has
> > signature 0x50434303
> Sorry for my mistake. I know this.
> I mean, why doesn't the following macro follow spec and define this
> signature as 0x504*3*430.
> "#define PCC_SIGNATURE **0x504*2*4300*"*
> Because it seems that all version of ACPI spec is 0x5043430.

Sorry my mistake. Stupidly the existing drivers have it wrong and I just
copied them without paying much attention. I will fix it up. It must be
0x50434300 instead of 0x50424300. If you have no other comments, can you
please ack v2 patch 4/4 changing soc kunpeng_hccs driver. I will fixup
the PCC_SIGNATURE and send it as part of my PR to Rafael.

Refer [1] for the change in PCC_SIGNATURE, sorry for missing the point. I
was confident that the existing code is correct :), but I am wrong.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/l/pcc_defines

