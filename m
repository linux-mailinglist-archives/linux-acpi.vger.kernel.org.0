Return-Path: <linux-acpi+bounces-124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717D7AE81C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 3F4C41F25744
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50412B7D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 08:31:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CE4C60;
	Tue, 26 Sep 2023 06:47:24 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3378E6;
	Mon, 25 Sep 2023 23:47:22 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vsvn-Og_1695710837;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsvn-Og_1695710837)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 14:47:19 +0800
Message-ID: <9ae398ff-c6a2-fde8-a767-3b42a86b9c38@linux.alibaba.com>
Date: Tue, 26 Sep 2023 14:47:17 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type
 and record struct to common header
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org,
 lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com,
 linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-efi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
 baolin.wang@linux.alibaba.com
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
 <202309251012.AD87704BB@keescook>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <202309251012.AD87704BB@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/26 01:13, Kees Cook wrote:
> On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
>> Move pstore creator id, section type and record struct to the common
>> header, so that it can be use by MCE and GHES driver.
> 
> I would prefer this was not in the pstore header -- this is a backend
> detail that should stay in backend headers.
> 
> -Kees
> 

Hi, Kees,

Which file do you prefer? Do you mean "include/linux/cper.h", it defines
the standard CPER sections, e.g. CPER_SEC_PLATFORM_MEM, CPER_SEC_PCIE, etc.

Thank you for comments.

Best Regards,
Shuai

