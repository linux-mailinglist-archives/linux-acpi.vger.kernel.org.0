Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56462369767
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhDWQws (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 12:52:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:2530 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWQws (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 12:52:48 -0400
IronPort-SDR: g7K9jvxDl5NppWCCQw4j10SepOrIbirZb2luqKEvXzGg6q5HEZOTrgT4Bd/UuypQHoTxF8Pui1
 wXLCG5ZNfmDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="281427420"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="281427420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:52:10 -0700
IronPort-SDR: bbyL92erHUGDShb1LCpsSOtF7mwd8kqB5zuoolqor0UTDicuxCNLS8w8hEMs64AjsTZh4cfpLl
 bWMknudXqebg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="456289153"
Received: from aberdasc-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.2.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 09:52:10 -0700
Subject: Re: [PATCH v2 1/1] ACPICA: Add SVKL table headers
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20210422214930.716596-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0gH-Zg7YZPf9joaMt1zfYfNkUGpo596=9QEJ1NKAw87qQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <df09a419-c881-c987-ef07-1b0e05bb171e@linux.intel.com>
Date:   Fri, 23 Apr 2021 09:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gH-Zg7YZPf9joaMt1zfYfNkUGpo596=9QEJ1NKAw87qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/23/21 5:36 AM, Rafael J. Wysocki wrote:
> Evidently, this is ACPICA material, so I'm expecting to receive this
> patch from Erik within the normal ACPICA development process, so I'm
> not sure what the purpose of this submission is.
> 

Erik already sent a pull request to merge this patch to ACPICA repo.

After he updated the ACPICA commit ID, he sent it to me for Linux
submission.

I am not sure whether there is a special process for ACPICA related
submission to Linux kernel. But if I had to guess, since I have sent
both SVKL and MADT patches at the same time, Erik might have assumed
that it should be merged in the same patch set and hence sent to me
for upstream submission.

> Has this patch been posted here for reference only?

If this submission is incorrect, I can request Erik to submit it again
for upstream merge.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
