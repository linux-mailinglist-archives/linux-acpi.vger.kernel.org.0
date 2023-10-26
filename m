Return-Path: <linux-acpi+bounces-1012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27657D80E4
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A01C20E14
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432B2D03C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E632D02B;
	Thu, 26 Oct 2023 10:21:34 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9592199;
	Thu, 26 Oct 2023 03:21:27 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vuxb1G0_1698315681;
Received: from 30.240.112.233(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vuxb1G0_1698315681)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 18:21:23 +0800
Message-ID: <8093ceb3-0857-4c36-8856-72a158e47b6c@linux.alibaba.com>
Date: Thu, 26 Oct 2023 18:21:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] Use ERST for persistent storage of MCE and
 APEI errors
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Borislav Petkov <bp@alien8.de>
Cc: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com,
 linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
 baolin.wang@linux.alibaba.com
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
 <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <f654be8f-aa98-1bed-117b-ebdf96d23df1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/10/7 15:15, Shuai Xue wrote:
> 
> 
> On 2023/9/28 22:43, Borislav Petkov wrote:
>> On Mon, Sep 25, 2023 at 03:44:17PM +0800, Shuai Xue wrote:
>>> After /dev/mcelog character device deprecated by commit 5de97c9f6d85
>>> ("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
>>> serialized MCE error record, of previous boot in persistent storage is not
>>> collected via APEI ERST.
>>
>> You lost me here. /dev/mcelog is deprecated but you can still use it and
>> apei_write_mce() still happens.
> 
> Yes, you are right. apei_write_mce() still happens so that MCE records are
> written to persistent storage and the MCE records can be retrieved by
> apei_read_mce(). Previously, the task was performed by the mcelog package.
> However, it has been deprecated, some distributions like Arch kernels are
> not even compiled with the necessary configuration option
> CONFIG_X86_MCELOG_LEGACY.[1]
> 
> So, IMHO, it's better to add a way to retrieve MCE records through switching
> to the new generation rasdaemon solution.
> 
>>
>> Looking at your patches, you're adding this to ghes so how about you sit
>> down first and explain your exact use case and what exactly you wanna
>> do?
>>
>> Thx.
>>
> 
> Sorry for the poor cover letter. I hope the following response can clarify
> the matter.
> 
> Q1: What is the exact problem?
> 
> Traditionally, fatal hardware errors will cause Linux print error log to
> console, e.g. print_mce() or __ghes_print_estatus(), then reboot. With
> Linux, the primary method for obtaining debugging information of a serious
> error or fault is via the kdump mechanism. Kdump captures a wealth of
> kernel and machine state and writes it to a file for post-mortem debugging.
> 
> In certain scenarios, ie. hosts/guests with root filesystems on NFS/iSCSI
> where networking software and/or hardware fails, and thus kdump fails to
> collect the hardware error context, leaving us unaware of what actually
> occurred. In the public cloud scenario, multiple virtual machines run on a
> single physical server, and if that server experiences a failure, it can
> potentially impact multiple tenants. It is crucial for us to thoroughly
> analyze the root causes of each instance failure in order to:
> 
> - Provide customers with a detailed explanation of the outage to reassure them.
> - Collect the characteristics of the failures, such as ECC syndrome, to enable fault prediction.
> - Explore potential solutions to prevent widespread outages.
> 
> In short, it is necessary to serialize hardware error information available
> for post-mortem debugging.
> 
> Q2: What exactly I wanna do:
> 
> The MCE handler, do_machine_check(), saves the MCE record to persistent
> storage and it is retrieved by mcelog. Mcelog has been deprecated when
> kernel 4.12 released in 2017, and the help of the configuration option
> CONFIG_X86_MCELOG_LEGACY suggest to consider switching to the new
> generation rasdaemon solution. The GHES handler does not support APEI error
> record now.
> 
> To serialize hardware error information available for post-mortem
> debugging:
> - add support to save APEI error record into flash via ERST before go panic,
> - add support to retrieve MCE or APEI error record from the flash and emit
> the related tracepoint after system boot successful again so that rasdaemon
> can collect them
> 
> 
> Best Regards,
> Shuai
> 
> 
> [1] https://wiki.archlinux.org/title/Machine-check_exception


Hi, Borislav,

I would like to inquire about your satisfaction with the motivation
provided. If you have no objections, I am prepared to address Kees's
comments, update the cover letter, and proceed with sending a new version.

Thank you.

Best Regards,
Shuai


