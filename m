Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A247E3A4A
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391271AbfJXRoN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 13:44:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391131AbfJXRoN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 13:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571939051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQKRdHfTr5lAKhTpoe9yAs8nMyR0CW+pX1KQDDAOGbM=;
        b=GPE5rMZsS7/VhgFGAKa2oPk5zsUYJWC9TFTZmYDR1Cpm4ycJC2a4o1Cz5SkeijUMUkpfP+
        k9fTWGMbNaFMkM/bHuSsKDjd/ULoJNtx99pENrs9jFluWw1vhelgsOS4O6l/Zxelj3VK/g
        DYqL2gabj0NzKxPpZ5rB8PLHhBP5FIo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-a3hbpgfMOxu07ShnmpowUA-1; Thu, 24 Oct 2019 13:44:09 -0400
Received: by mail-wm1-f71.google.com with SMTP id z5so1563579wma.5
        for <linux-acpi@vger.kernel.org>; Thu, 24 Oct 2019 10:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jgG2qjFPSy4I51VHT9fkE4WeQBOJ33igKOfXfQL20CU=;
        b=G9Xm8QHYM4/0FkKSfMsbQnwx1Qh4NBiZG6Bkg/CzWhqpQJwfM/lenjNQTJNOGrfJQk
         4bMrrJ/aGGQ+nHid0FrMJKVnNqcIegBHEfKCqTzCZxFERTf7PpLzT8/1Rvp0J1xdVch0
         lLK5wmAjOKpJ0ZWXFMLUbu7Ql4F++BidaRPGfqZBn2HhLdliLdmeFLa+9c1TM1T2DKA3
         A9i6a5FRNCRrvDkMz4zjoGmaqrHlVIj3phDMNyA6VVkgfrYZo8D8hdqX4QVSzq5UD6O9
         HLsA5z0r3aJuXrD7ZzNSkxkgbuWcpybMx3MPEPPA/DxPqMRlpjmTyKceolNxsDKldNuH
         H42w==
X-Gm-Message-State: APjAAAUnZCFsDOjy70mFiohkJBSIkN9zI7tY3JShtbEFL9JWp0cFK+0f
        mR6gVSMUAEaiTqRR0bkKnQu6WF88ZCz5cVcNIsj6UUJzSG25zZxBrfmxpqkbi9QzvqTWZYZZnz2
        rj+JfojfK7hmBfwzgWu8LHQ==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr4798481wrt.21.1571939047828;
        Thu, 24 Oct 2019 10:44:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXMCPhWlzep6nYBeuexovHLErP1et4URbjBPZJhgakMHIVidK5CfMWDTabhMtG+bxT48Nc1g==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr4798468wrt.21.1571939047609;
        Thu, 24 Oct 2019 10:44:07 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id x7sm37330268wrg.63.2019.10.24.10.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:44:06 -0700 (PDT)
Subject: Re: [PATCH 3/5] ACPI: button: Turn lid_blacklst dmi table into a
 generic quirk table
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20191018194115.93281-1-hdegoede@redhat.com>
 <20191018194115.93281-3-hdegoede@redhat.com>
 <20191021090826.GI32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1bf58f8c-c3d1-f61b-55f0-4b68cee280b8@redhat.com>
Date:   Thu, 24 Oct 2019 19:44:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021090826.GI32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: a3hbpgfMOxu07ShnmpowUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 21-10-2019 11:08, Andy Shevchenko wrote:
> On Fri, Oct 18, 2019 at 09:41:13PM +0200, Hans de Goede wrote:
>> Commit 3540c32a9ae4 ("ACPI / button: Add quirks for initial lid state
>> notification") added 3 different modes to the LID handling code to deal
>> with various buggy implementations.
>>
>> Until now users which need one of the 2 non-default modes to get their
>> hw to work have to pass a kernel commandline option for this.
>>
>> E.g. https://bugzilla.kernel.org/show_bug.cgi?id=3D106151 was closed wit=
h a
>> note that the user has to add "button.lid_init_state=3Dopen" to the kern=
el
>> commandline to get the LID code to not cause undesirable suspends on his
>> Samsung N210 Plus.
>>
>> This commit modifies the existing lid_blacklst dmi table so that it can
>> be used not only to completely disable the LID code on devices where
>> the ACPI tables are broken beyond repair, but also to select one of the =
2
>> non default LID handling modes on devices where this is necessary.
>>
>> This will allow us to add quirks to make the LID work OOTB on broken
>> devices. Getting this working OOTB is esp. important because the typical
>> breakage is false LID closed reporting, causing undesirable suspends whi=
ch
>> basically make the system unusable.
>=20
>> +static int lid_init_state =3D -1;
>=20
>>   static int acpi_button_register_driver(struct acpi_driver *driver)
>>   {
>> +=09const struct dmi_system_id *dmi_id;
>> +
>> +=09if (lid_init_state =3D=3D -1) {
>> +=09=09dmi_id =3D dmi_first_match(dmi_lid_quirks);
>> +=09=09if (dmi_id)
>=20
>> +=09=09=09lid_init_state =3D (long)dmi_id->driver_data;
>=20
> I would rather see here (intptr_t), though up to you and Rafael.
> Or mark a variable long itself?

I will make the variable itself long for v2.

>> +=09=09else
>> +=09=09=09lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
>=20
> Can't we simple default the value to this?

No then we do not know if this value was set as module option by
the user, or if it is just the default and we should not use the
dmi based quirks when the value is set by the user, so we must
be able to distinguish the 2 cases.

Regards,

Hans

