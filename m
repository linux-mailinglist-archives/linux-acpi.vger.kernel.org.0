Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0C1988B4
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 02:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgCaANn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 20:13:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgCaANn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2020 20:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=JaNBaI5ODzz69YpdR1NiBrpIIhmZrZWZTY/GzTI2SZ8=; b=QvgAjlHUZLNqHLlge9mPQDRDdM
        Rdx+MrTe21Qfde+XLC3tOHLNbT8nMXjm2ihtELQu+BFFfXtQprBT4BTZpP+BZX4je/ml17Dbq955F
        ot140aLMKprbxjaS8YeBrDmU3ASohYTC4mzQImgnz8I1GZCWXYINstbmO9X/QAiP3TjCAo7SxRSKx
        XRHlDOXGPtA2wkvE4GO5Dpt2aLvFJyulPktstU51ELxwzveounNRDJ89n8duNNRqP7Ed/T/krx6KJ
        aO8qWBsUgH3n+YWUjArkoyPBS0QdA4BLBFWevVtccOFxuvRrlyDVEDAdFrR/aQm7hgxXDzq2Dcje0
        FimSI88A==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ4XF-0005xW-1J; Tue, 31 Mar 2020 00:13:41 +0000
Subject: Re: ACPI Video Driver creates backlight on desktop board
To:     Hans de Goede <hdegoede@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <75866748-f574-ae50-6183-ef6892c935c5@molgen.mpg.de>
 <63956e11-46f2-72f4-c722-8fee2cbfbfa1@redhat.com>
 <9a934fe8-9279-094c-e589-9e439c000b04@infradead.org>
 <3981bf9d-e721-628e-b88a-c75614a5cc64@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1c36df4c-75a4-079d-9469-4a1cb18b3c23@infradead.org>
Date:   Mon, 30 Mar 2020 17:13:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3981bf9d-e721-628e-b88a-c75614a5cc64@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/30/20 2:32 PM, Hans de Goede wrote:
> Hi,
> 
> On 3/30/20 11:25 PM, Randy Dunlap wrote:
>> On 3/30/20 1:51 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 3/29/20 11:36 AM, Paul Menzel wrote:
>>>> Dear Linux folks,
>>>>
>>>>
>>>> On the MSI desktop board [1]
>>>>
>>>>       [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.MR 12/02/2019
>>>>
>>>> with an AMD Ryzen 3 2200G with Radeon Vega Graphics, the ACPI Video Driver `video` is loaded and creates a backlight device.
>>>>
>>>>       $ readlink -f /sys/class/backlight/acpi_video0
>>>>       /sys/devices/pci0000:00/0000:00:08.1/0000:26:00.0/backlight/acpi_video0
>>>>
>>>> I wonder what the driver is used for as the AMDGPU driver exists for the graphics device.
>>>
>>> Backlight on x86 hw is a bit of a mess, there is an ACPI standard for accessing it
>>> and with older (Windows XP era) laptops that is the interface which usually works,
>>> then there are a bunch of vendor specific SMBIOS or WMI backlight interfaces and
>>> then there is the option of directly accessing the hardware as the amdgpu driver
>>> is doing.
>>>
>>> We have a bunch of heuristics to avoid the acpi_video driver registering a
>>> backlight interface when it should not, either because the direct hw access
>>> should be used instead; or because there simply is no builtin LCD panel and thus
>>> no backlight to control.
>>>
>>> These heuristics are failing on your board.
>>>
>>>> If it’s useful, is there a way to prevent the backlight interface from getting created?
>>>
>>> You can pass "acpi_backlight=ignore" on the kernel commandline to disable the
>>
>> Hi Hans,
>> Should that be "acpi_backlight=none"?  I don't see 'ignore' allowed here:
>>
>> static void acpi_video_parse_cmdline(void)
>> {
>>     if (!strcmp("vendor", acpi_video_backlight_string))
>>         acpi_backlight_cmdline = acpi_backlight_vendor;
>>     if (!strcmp("video", acpi_video_backlight_string))
>>         acpi_backlight_cmdline = acpi_backlight_video;
>>     if (!strcmp("native", acpi_video_backlight_string))
>>         acpi_backlight_cmdline = acpi_backlight_native;
>>     if (!strcmp("none", acpi_video_backlight_string))
>>         acpi_backlight_cmdline = acpi_backlight_none;
>> }
> 
> Yes you are right that should be "acpi_backlight=none".
> 
>> and Documentation/admin-guide/kernel-parameters.txt could stand to be updated
>> with a few of those options.
> 
> Ack, I've put this on my (much too long) TODO list. Feel free to
> beat me to it.

Sure, I'll send a patch shortly.

-- 
~Randy

