Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4E28F159
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 13:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgJOLc2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 07:32:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:51945 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgJOLcC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 07:32:02 -0400
IronPort-SDR: uG6Rv/2onncRIPPeF8mtgQMuBtoLuEhE0JwRqksdMh/esurFtcw2FM7uBobPKmzqKe8O39M33c
 U2GuNnfEPE+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162859527"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="162859527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 04:31:59 -0700
IronPort-SDR: gjXN4EMTaMtAsC6kyIaQL+CpHnMMbFXQGl2oEvfG+5m72mH7GcvHpMNdMkGNzkzZbT+hDoR3KX
 9aXKPouyWisA==
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="531219798"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.151.178]) ([10.249.151.178])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 04:31:58 -0700
Subject: Re: DPTF_POWER and DPTF_PCH_FIVR
To:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, rafael@kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
References: <20201015095311.GA11838@zn.tnic> <20201015095851.GB11838@zn.tnic>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <d6cdf27b-04ef-7bc8-03ef-2115ca08bffe@intel.com>
Date:   Thu, 15 Oct 2020 13:31:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201015095851.GB11838@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/15/2020 11:58 AM, Borislav Petkov wrote:
> On Thu, Oct 15, 2020 at 11:53:11AM +0200, Borislav Petkov wrote:
>> Dudes,
>>
>> what are those new symbols in Kconfig and why do they wanna get enabled
>> on my box when doing oldconfig? Depends on X86? Really, that widespread?

Well, they depend on ACPI too and it doesn't look like there is anything 
more fine grained that could be used here.

Also I'm not sure if adding ACPI_DPTF (bool, disabled by default and 
depending on x86) would help a lot.


>> The help text doesn't say why do I need this...
> And that thing in sysfs:
>
> "/sys/bus/platform/drivers/DPTF Platform Power"
>
> has spaces in the name. What's going on?!
>
Obviously an oversight on my part, sorry.

I think that changing it to "dptf_power" (and analogously for the FIVR 
participant driver) should work.  Srinivas?


