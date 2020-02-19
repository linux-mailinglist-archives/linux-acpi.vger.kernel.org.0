Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB8163D7C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2020 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgBSHaI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Feb 2020 02:30:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36906 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbgBSHaI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Feb 2020 02:30:08 -0500
X-IronPort-AV: E=Sophos;i="5.70,459,1574092800"; 
   d="scan'208";a="83550924"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Feb 2020 15:30:04 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 2645B50A9975;
        Wed, 19 Feb 2020 15:20:23 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Wed, 19 Feb 2020 15:30:00 +0800
Subject: Re: [RFC PATCH 0/2] x86/boot: early ACPI MADT processing cleanup
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
References: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <ea435734-c18d-b6b9-a729-e0c5e6e62991@cn.fujitsu.com>
Date:   Wed, 19 Feb 2020 15:32:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200123014144.19155-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 2645B50A9975.A6B69
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ping.

On 1/23/20 9:41 AM, Cao jin wrote:
> Logic in early_acpi_process_madt() & acpi_process_madt() is really hard to
> follow now. Clean them up.
> 
> Done basic boot test on my x86-64 PC.
> 
> CCed linux-acpi@vger.kernel.org
> 
> Cao jin (2):
>   x86/acpi: Improve code readablity of early madt processing
>   x86/acpi: Cleanup acpi_process_madt()
> 
>  arch/x86/kernel/acpi/boot.c | 72 +++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
> 


-- 
Sincerely,
Cao jin


