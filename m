Return-Path: <linux-acpi+bounces-2089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1C801D46
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0CE1F2116C
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76071B295
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjOVjawI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F6102
	for <linux-acpi@vger.kernel.org>; Sat,  2 Dec 2023 05:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701523245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZttw52m3Y5BO6pRmTs4fgflOUqVdmw26+ZPrsBdZjU=;
	b=bjOVjawIBqzxU6JsrOG0JHx1OyThriw5SmPTEmKFJlJ39mY2R6dx/4qRCivFbastMfmQbx
	ELzm325C9Erv2U6FtjOT8QG7b2xOA/pVvePvOPuznyHGGUTjA0QA1Verax18MJ5w8pQLpV
	GEho2jgMncYTJOjzhdVfqeqCuaVrmdA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-rp8RGNbdOPSuCQs1mj7yMA-1; Sat, 02 Dec 2023 08:20:43 -0500
X-MC-Unique: rp8RGNbdOPSuCQs1mj7yMA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b2977d6baso21214555e9.2
        for <linux-acpi@vger.kernel.org>; Sat, 02 Dec 2023 05:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701523242; x=1702128042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZttw52m3Y5BO6pRmTs4fgflOUqVdmw26+ZPrsBdZjU=;
        b=Z3+im/S6BRKuIEjnsJ11JTgcvVWHq6gU1yhgrtdLcCrkvL314KnbX47qG9jKkBC847
         yp6osrn6WsG8X7o10xUlNeYmN7n642gjwK2Ky1V8xItIHfPe3O0xqu3m/jB8TDY5FpZK
         ezEL9z+qEnQ06sk/WGEO5EsAvymicSn8hvSevDMubLQReqf2U/VOFjUlB/PqZiVuQrI4
         f7ia5SPPnItBpZZy16xrm08n7EHwNyodfHoFobHwBn5urRJXoFXIl0/xx4aowZg0dygq
         JcUigaqk6UOxiiyOiZbPRWCd7NsSNweFhwf/lIFj4zG2a750W3NRu6KHT76Pd8KjkI+5
         w3+A==
X-Gm-Message-State: AOJu0Yztr6DXrxblpFC5csVw7hXdfjjD8cdyBmq0OeefyhM02fy7S1XE
	yV87MtoyrDRG2ammlTeV24cp9Ujat46JvEmhBiMjJGgB3p/ipLIRuzF/56PHLvw/4UkhzL75xjL
	fit+N6KjlnrgBDdNdUOA5sCwf8Zd4Vg==
X-Received: by 2002:a05:600c:4f11:b0:40b:5e21:ec2d with SMTP id l17-20020a05600c4f1100b0040b5e21ec2dmr1121577wmq.95.1701523242235;
        Sat, 02 Dec 2023 05:20:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLltLfkoO5OH2qY5+ren3SKxd2ZTe11cQhLH7Sg7oQT2aEydS/UK0AWu4SPL2rbaimjc+NaA==
X-Received: by 2002:a05:600c:4f11:b0:40b:5e21:ec2d with SMTP id l17-20020a05600c4f1100b0040b5e21ec2dmr1121569wmq.95.1701523241891;
        Sat, 02 Dec 2023 05:20:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fd22-20020a056402389600b0054c21d1fda7sm1932805edb.1.2023.12.02.05.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 05:20:41 -0800 (PST)
Message-ID: <b9319272-5e29-4de6-8921-fdac474e421f@redhat.com>
Date: Sat, 2 Dec 2023 14:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] ACPI: acpi_video: Replace acpi_driver with
 platform_driver
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
 lenb@kernel.org
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
 <20231025111806.2416524-5-michal.wilczynski@intel.com>
 <CAJZ5v0h2G6i0qXvSyFJeC4zsML3yxGZvUt-nUPs2Z3iHEM845A@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0h2G6i0qXvSyFJeC4zsML3yxGZvUt-nUPs2Z3iHEM845A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 11/29/23 15:19, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Wed, Oct 25, 2023 at 2:35 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>>
>> The acpi_video driver uses struct acpi_driver to register itself while it
>> would be more logically consistent to use struct platform_driver for this
>> purpose, because the corresponding platform device is present and the
>> role of struct acpi_device is to amend the other bus types. ACPI devices
>> are not meant to be used as proper representation of hardware entities,
>> but to collect information on those hardware entities provided by the
>> platform firmware.
>>
>> Use struct platform_driver for registering the acpi_video driver.
>>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> 
> Do you have any particular concerns regarding this change?  For
> example, are there any setups that can break because of it?

I have just given this a quick test spin and on most hw
it actually causes the apci_video driver to not bind
anymore *at all* which will cause a bunch of brokenness
all over the place.

The problem is that the physical-node for which the 
/sys/bus/acpi/devices/LNXVIDEO:00 fwnode / acpi-companion node 
is the companion normally is the GPU, which is a PCI
device so no /sys/bus/platform/devices/LNXVIDEO:00
device is instantiated for the new "video" platform driver
to bind to.

While I appreciate the efforts being done to clean up
the ACPI subsystem I must also say that this makes me
question how well all these convert to platform driver
patches are tested ?

Almost all modern x86 hw has a /sys/bus/acpi/devices/LNXVIDEO:00
device, so this can be tested almost everywhere and this should
have been caught during testing by a test as simple as:

1. "ls /sys/bus/platform/devices/LNXVIDEO:00" and notice this
does not exist and/or:
2. "ls /sys/bus/platform/drivers/video/" and notice it has not
bound to anything where before this change the acpi_video
module would have bound to /sys/bus/acpi/devices/LNXVIDEO:00

Also the "Video Bus" input/evdev device is now gone
from "sudo evtest" which is a third quick way to see this
now all no longer works.

One possible way to solve this is to treat LNXVIDEO devices
specially and always create a platform_device for them.

This will also require some changes to the modalias
and driver-matching code because normally acpi:xxxx
modaliases are only used / matched when the platform_device
is the first physical node, where as I think
the platform_device will end up being the second physical
node now.

One last remark, assuming we find a way to solve this,
then IMHO the .name field in the driver:

>> +static struct platform_driver acpi_video_bus = {
>> +       .probe = acpi_video_bus_probe,
>> +       .remove_new = acpi_video_bus_remove,
>> +       .driver = {
>> +               .name = "video",
>> +               .acpi_match_table = video_device_ids,
>> +       },
>>  };

MUST not be just "video" platform devices <-> drivers  also get
matched by dev_name() so if anyone now creates a platform_device
named "video" then the platform_bus will now bind this driver
to it. "acpi_video", matching the .c filename (but not the module
name for historical reasons) would be better IMHO.

Regards,

Hans



