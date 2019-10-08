Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A8D0304
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJHVqR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 17:46:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbfJHVqQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Oct 2019 17:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570571174;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+eZJJqrlbPqVzOZaO5qNFGym7u5qYSToEyvJ0eC7yw=;
        b=Lg/Xuh+kz9tHluSSkVod1pJsysK5iilKFhf44z+hB0fHEDHqKYC/3xocRk03SoqAFzaNlk
        04dMv1OsEwtUPnV0okT1Aj5K0taXUpq0auQDIK3p/Q2kCA4ioxuwOYRr8+UZUswQcYb5Eo
        s8N3l656zgauAO8MHxJmJq62BHEa8uw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-fbFszj3IOWijUUdaBxAK6w-1; Tue, 08 Oct 2019 17:46:12 -0400
Received: by mail-io1-f72.google.com with SMTP id a22so522782ioq.23
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2019 14:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2PLCpCGC+X0FsCVNcoIrm/LGH7IA7bRES0qF3Fhu7k=;
        b=OgPemI9hlVZFgiwSlm/y+21PZEE/Fj6k58bN1ebzTpXNew1IAO1IowiC8BJ8BHHnOP
         Ye1/PSS9raFw3DT2GhO9MM9+v5vgUtgBKkdN7lXogbWDXPk9Ghej9uzdUJsPVSO2a06f
         iSRozJqVh1yt+VJPXl6yRKl2jDQtJfg0lS9DQVGBy1NDslQWo1FodcoIqZyHL6fbpHd+
         1lRtDAOXvi/TXbRgAuiYe632x5vhp/gsjzi6WED2NQRHZQC9iZG9uznEaQ2zWoeEAqRr
         Yzpxr1uy2ftyyMMHbOL5ggko2vxpcYQzVYZMiaWR2ZvT8gdAiaImXbzzmEaf48rVN4cb
         iYOA==
X-Gm-Message-State: APjAAAWbKRsgi0X+bLRI1A3HjpmWO6XNxm7QOSWqLjD3LaJsX5WNYv4f
        e9lQ7nosRK9OWf0woQ0gRoQDsM39sVk8BfY7HtdE+HURZafYiYX/QzfbY3FaThBi2ziWzT8ThHH
        JW99Z5sDfvHqcBWBpfWe93w==
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr158796jan.11.1570571172226;
        Tue, 08 Oct 2019 14:46:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzRjkZNUFsMLmBAav/k9nqbRyvIxfGbTW0hIWLHgfdTSVeQ7myWycO2xJSmj0J/txoJdC1z/Q==
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr158772jan.11.1570571171801;
        Tue, 08 Oct 2019 14:46:11 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id v69sm174162ila.6.2019.10.08.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 14:46:11 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:46:09 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191008214609.wk2imvejk2h2pvil@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
 <20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: fbFszj3IOWijUUdaBxAK6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue Oct 01 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>---
> drivers/iommu/amd_iommu.c | 30 +++++-------------------------
> 1 file changed, 5 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..40f3cf44aa98 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -124,30 +124,6 @@ static struct lock_class_key reserved_rbtree_key;
>  *
>  ************************************************************************=
****/
>
>-static inline int match_hid_uid(struct device *dev,
>-=09=09=09=09struct acpihid_map_entry *entry)
>-{
>-=09struct acpi_device *adev =3D ACPI_COMPANION(dev);
>-=09const char *hid, *uid;
>-
>-=09if (!adev)
>-=09=09return -ENODEV;
>-
>-=09hid =3D acpi_device_hid(adev);
>-=09uid =3D acpi_device_uid(adev);
>-
>-=09if (!hid || !(*hid))
>-=09=09return -ENODEV;
>-
>-=09if (!uid || !(*uid))
>-=09=09return strcmp(hid, entry->hid);
>-
>-=09if (!(*entry->uid))
>-=09=09return strcmp(hid, entry->hid);
>-
>-=09return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
>-}
>-
> static inline u16 get_pci_device_id(struct device *dev)
> {
> =09struct pci_dev *pdev =3D to_pci_dev(dev);
>@@ -158,10 +134,14 @@ static inline u16 get_pci_device_id(struct device *d=
ev)
> static inline int get_acpihid_device_id(struct device *dev,
> =09=09=09=09=09struct acpihid_map_entry **entry)
> {
>+=09struct acpi_device *adev =3D ACPI_COMPANION(dev);
> =09struct acpihid_map_entry *p;
>
>+=09if (!adev)
>+=09=09return -ENODEV;
>+
> =09list_for_each_entry(p, &acpihid_map, list) {
>-=09=09if (!match_hid_uid(dev, p)) {
>+=09=09if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
> =09=09=09if (entry)
> =09=09=09=09*entry =3D p;
> =09=09=09return p->devid;
>--=20
>2.23.0
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

