Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D797198665
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgC3VZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 17:25:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgC3VZV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2020 17:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UE2wAGGu8ya9NawySRvYrWAaplmOOYGqNRobWUtfUl8=; b=ARWUMeOzzQMeW+6dlpJz8CB+R0
        qMaxaGtKmlD0D4TDU1U0A68N88krwQgHmeqZDlj9KPQvz9BwaLuVzgvJvlAczb8E/iHQ2hcmnLS+Q
        O/Te1QsKFzrNYwoyaYeL2WZz33NqKwtpTrxjGGXeOLxs1Uivhi4En7WP+l1tDklwQEb4Rftlfqv5k
        NmuO9+ytokJGC+HidZNbbQKPE+WaZx1NbNlKHp5heGyOxohNrr/KRmFeld+jyEFSvzOyyOZEToTnA
        bVX6Pw/xF+AWG07KQ+iiyPOU2coNVDcxifvhCwdVdYCMgTyFn9WWH3064gwlkfXCcZTjz7YjwEjYL
        Z4TcL9vw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJ1uJ-0007ub-6z; Mon, 30 Mar 2020 21:25:19 +0000
Subject: Re: ACPI Video Driver creates backlight on desktop board
To:     Hans de Goede <hdegoede@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <75866748-f574-ae50-6183-ef6892c935c5@molgen.mpg.de>
 <63956e11-46f2-72f4-c722-8fee2cbfbfa1@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a934fe8-9279-094c-e589-9e439c000b04@infradead.org>
Date:   Mon, 30 Mar 2020 14:25:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <63956e11-46f2-72f4-c722-8fee2cbfbfa1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/30/20 1:51 PM, Hans de Goede wrote:
> Hi,
> 
> On 3/29/20 11:36 AM, Paul Menzel wrote:
>> Dear Linux folks,
>>
>>
>> On the MSI desktop board [1]
>>
>>      [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.MR 12/02/2019
>>
>> with an AMD Ryzen 3 2200G with Radeon Vega Graphics, the ACPI Video Driver `video` is loaded and creates a backlight device.
>>
>>      $ readlink -f /sys/class/backlight/acpi_video0
>>      /sys/devices/pci0000:00/0000:00:08.1/0000:26:00.0/backlight/acpi_video0
>>
>> I wonder what the driver is used for as the AMDGPU driver exists for the graphics device.
> 
> Backlight on x86 hw is a bit of a mess, there is an ACPI standard for accessing it
> and with older (Windows XP era) laptops that is the interface which usually works,
> then there are a bunch of vendor specific SMBIOS or WMI backlight interfaces and
> then there is the option of directly accessing the hardware as the amdgpu driver
> is doing.
> 
> We have a bunch of heuristics to avoid the acpi_video driver registering a
> backlight interface when it should not, either because the direct hw access
> should be used instead; or because there simply is no builtin LCD panel and thus
> no backlight to control.
> 
> These heuristics are failing on your board.
> 
>> If it’s useful, is there a way to prevent the backlight interface from getting created?
> 
> You can pass "acpi_backlight=ignore" on the kernel commandline to disable the

Hi Hans,
Should that be "acpi_backlight=none"?  I don't see 'ignore' allowed here:

static void acpi_video_parse_cmdline(void)
{
	if (!strcmp("vendor", acpi_video_backlight_string))
		acpi_backlight_cmdline = acpi_backlight_vendor;
	if (!strcmp("video", acpi_video_backlight_string))
		acpi_backlight_cmdline = acpi_backlight_video;
	if (!strcmp("native", acpi_video_backlight_string))
		acpi_backlight_cmdline = acpi_backlight_native;
	if (!strcmp("none", acpi_video_backlight_string))
		acpi_backlight_cmdline = acpi_backlight_none;
}

and Documentation/admin-guide/kernel-parameters.txt could stand to be updated
with a few of those options.


> interface, this will stop e.g. gnome from showing a non working brightness
> slider in its top right system menu.
> 
> If this works you can make this permanent and avoid other users from having to
> do the same thing by writing a patch adding a quirk for this like this one:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21a91629f4b8e794fc4c0e0c17c85cedf1d806c


-- 
~Randy

