Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA229E7C3
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 10:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJ2Jsu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 05:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgJ2Jsu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 05:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603964929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KJlkq3/BGQtIyxTwp58xi3W5HAqPcTXyT9iN2EHXlYE=;
        b=D4Gh9uqnBjZj7RGVESdEAVQGUsQlzDFOAgy+0h8/VuyNT2Bnklsq/qf9GbI+sCQbro8oEN
        mNs7C5XPw2fjwWzg9WVuMURaRDykB1npWqAi8RFCnNvIruribgYwDoVaPxIOh6okcp2oaj
        zBG+lTTnH+NH1pCT7pK4X7WtfMMXED4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-vv0Zrkx_MzqqBKHyBwhPJw-1; Thu, 29 Oct 2020 05:48:45 -0400
X-MC-Unique: vv0Zrkx_MzqqBKHyBwhPJw-1
Received: by mail-ed1-f72.google.com with SMTP id m1so950623edr.8
        for <linux-acpi@vger.kernel.org>; Thu, 29 Oct 2020 02:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KJlkq3/BGQtIyxTwp58xi3W5HAqPcTXyT9iN2EHXlYE=;
        b=c00OFnkE+lYGOThhaRqYJf1zFRc2IxsVA26oxezqiIFk5QE3xuzynLTp3RoD4dyV/Z
         DI9DdA+psl8inDUPN61cc2h5Nd9wmq5Xg2vGiKzn6wY98etD8Qv90R+F1JJNnIiZhsEF
         R5pp7KEAkgclttMTL1YNAGj5oVReRz4bWNdSc0Vm4GyOJv2w7rg212Fie6So4++ohSqi
         jDZ9jexgygaqD2y5+UmXsY/j7E7Wlq4q017sVfXrNfIMzdaKpPjQso+Am1Pl0ahXYLPW
         PQ0zn0OoUTipnKdlWyj262jqyf6cIkjUlgwO6ePBPbvZzj2LTYzVPeCJFX0S8dpv9dGC
         /msA==
X-Gm-Message-State: AOAM531cW+/LhmCJe/yA424eijwu172n3vqRHyCfce1HPiaABB/VwKJr
        USaeF7Z2uJjFjvODUsMdyn9nZqS0rc0KUgYW7puGPXwC51hidYnmJuOjqIvVH+34RJC8CK4+uzy
        490Yb6t4AMQT4PwwLP42t6A==
X-Received: by 2002:aa7:d699:: with SMTP id d25mr3015313edr.44.1603964924378;
        Thu, 29 Oct 2020 02:48:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP67zM9YaGxazfrJKUjuYicpmLAyNYHMQRRj0cfquyKQf/e+ALbXvKe66MDs4TrC9y6Fa4YQ==
X-Received: by 2002:aa7:d699:: with SMTP id d25mr3015300edr.44.1603964924177;
        Thu, 29 Oct 2020 02:48:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id r1sm1166313eju.40.2020.10.29.02.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 02:48:43 -0700 (PDT)
Subject: Re: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <20201025094542.3669-1-hdegoede@redhat.com>
 <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
 <MWHPR11MB15990ABB3778816E4831FDF9F0160@MWHPR11MB1599.namprd11.prod.outlook.com>
 <d8330e68-c0ab-ab3c-ee13-3d9dc58ade7b@redhat.com>
 <MWHPR11MB1599E899E45EF55CB70A89A3F0170@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6e04d729-421e-c663-6d06-d69ec4c96556@redhat.com>
Date:   Thu, 29 Oct 2020 10:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1599E899E45EF55CB70A89A3F0170@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/28/20 11:33 PM, Kaneda, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Tuesday, October 27, 2020 12:00 PM
>> To: Kaneda, Erik <erik.kaneda@intel.com>; Moore, Robert
>> <robert.moore@intel.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; Len
>> Brown <lenb@kernel.org>
>> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> Subject: Re: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
>> OpRegions
>>
>> Hi,
>>
>> On 10/27/20 6:43 PM, Kaneda, Erik wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Moore, Robert <robert.moore@intel.com>
>>>> Sent: Tuesday, October 27, 2020 7:17 AM
>>>> To: Kaneda, Erik <erik.kaneda@intel.com>; Hans de Goede
>>>> <hdegoede@redhat.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; Len
>>>> Brown <lenb@kernel.org>
>>>> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>>>> Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for
>> GPIO
>>>> OpRegions
>>>>
>>>> Looks OK to me.
>>>
>>> Ok, I'll make a pull request of this to ACPICA on behalf of Hans and it will be
>> in the next ACPICA release.
>>
>> Great, thank you.
> 
> Pull request is available here: https://github.com/acpica/acpica/pull/644
> 
> Once it's merged, it'll be a part of the next ACPICA release.

Thank you for porting this to the ACPICA upstream code,
unfortunately you missed one change when porting this. I've added
a review pointing the missing bit out on github.

Specifically you missed this bit:

 		if ((next_node->type == ACPI_TYPE_REGION) &&
 		    (next_node->object) &&
-		    (next_node->object->region.space_id == ACPI_ADR_SPACE_EC)) {
+		    (next_node->object->region.space_id == space_id)) {
 			goto exit;	/* Do not execute the _REG */
 		}
 

Regards,

Hans

