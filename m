Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1745AFB0
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 00:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhKWXFI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 18:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhKWXFI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 18:05:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110EAC061574;
        Tue, 23 Nov 2021 15:01:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g14so1615458edb.8;
        Tue, 23 Nov 2021 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ht9E1p/DyzTpsAqMy6QR1zhTTEv9RdTNX9jIQ90EKf0=;
        b=qGLwsyoG1Pcf+l323FrU7zfkNsFBiEzV5p5s/wM7Hesk9nWnHJt0R1pIC6iiRlBomj
         NIf011wRJHUCAZWgYCsyh8UriNs3HfQjBFpDSXeoC/Cg21V2Yz5UOsuUK47O207wyekj
         +Qejdg9mnrlOc55iDAViSd0Iu/yIUcWRdvDbNskawt0WKFT0NcaMRLUHgG7TR6h2kpUw
         tOvVadWKaMapJYV7LYcfVTXwrorDKh/VKELoFAFbzKlNi1D8W90hZEziIj5B94Rga1f+
         iX4JVBap0gLwiltixQTrP9/YoYobHKAzMIaHZadLqsIabt6riHb9XERx98H/MucVrXHh
         PUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht9E1p/DyzTpsAqMy6QR1zhTTEv9RdTNX9jIQ90EKf0=;
        b=sEwCMuoBAKwemv4VGmf0ap8++9i0Cdnk/0IPMqhzLNd0ZM77C3i6UWLZomf82jdmms
         VbTnrlafhjjR7338FsGOoygyQBbsE1s/7A2QbwD1Cj6OmjcIIj0fyH7i5XifcjVWhyEL
         9RIlSMrftGgddT5sE9aUVY31Ecd0W1iWSfikQRJI2zn3MoudZm6j//XifRX3X+PVbT+1
         QPBRU/25yE0eQyARcyPGFR4XQEYhbBVPSBuv5XoOw2uhQLakQchIfANIWA9jyUnooUOq
         3IldL7wq/VjNbHmSHNdlPZv/G5ev0Bj2/d4RuDR/9ZmLlIKHdxRz2Tymw5I33wxtJaBC
         vSqg==
X-Gm-Message-State: AOAM53032+ZmkPo380Fxs7djAaXROpKSxtt3VhGBFTHB0vj+ccepa454
        vK2gkXYocNylyujNMiN5kGxxVZatqEeciurF/gQ=
X-Google-Smtp-Source: ABdhPJyGkjWgdJNmrGbvK5UhP73uvpIxjmfUItuL6e+QCzmzGC5HR6vmcZUBZndWYGeq7YneJzPMHREKrcnGnGuWkB8=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr13399358ejc.141.1637708517524;
 Tue, 23 Nov 2021 15:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-12-tanureal@opensource.cirrus.com>
 <87af37a2-dc02-2ae0-a621-b82c8601c16c@redhat.com> <756f813c-cc3e-7ddf-e5db-cf6c874f907e@opensource.cirrus.com>
 <1605be8d-0913-4b52-32e2-8076fff01d30@redhat.com>
In-Reply-To: <1605be8d-0913-4b52-32e2-8076fff01d30@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Nov 2021 01:01:21 +0200
Message-ID: <CAHp75VcanaEU89LXCs_CaBC5WvhotyuTeeS2FSxqhZntbz5FFg@mail.gmail.com>
Subject: Re: [PATCH 11/11] ACPI / scan: Create platform device for CLSA0100
 ACPI nodes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lucas tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 8:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/23/21 18:11, Lucas tanure wrote:
> > On 11/23/21 17:05, Hans de Goede wrote:
> >> On 11/23/21 17:31, Lucas Tanure wrote:
> >>> The ACPI device with CLSA0100 is a sound card with multiple
> >>> instances of CS35L41.
> >>>
> >>> We add an ID to the I2C multi instantiate list to enumerate
> >>> all I2C slaves correctly.

...

> >>> @@ -1708,6 +1708,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
> >>>           {"BSG2150", },
> >>>           {"INT33FE", },
> >>>           {"INT3515", },


> >>> +        {"CLSA0100", },

Can we keep it sorted, please?
Ditto for the other driver.

> >>>           {}

-- 
With Best Regards,
Andy Shevchenko
