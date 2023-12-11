Return-Path: <linux-acpi+bounces-2295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0024080D4C5
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 18:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244611C21518
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77D4F1E5;
	Mon, 11 Dec 2023 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NBFkepOO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC90C3
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 09:57:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso23839345e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702317440; x=1702922240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ+R8B3wHCuWt284dmb9Of0onfh+d3cgp76iNW/6Qqk=;
        b=NBFkepOOw19ltXFI+lrhjkoLrBMmbcPeWm3kf1KWQJk2ve9DcQrPd+5U1NnpAADeDy
         se1Q7rtK988ynzKIJMhhW16vsydT9Zo4lBcH5xNgImSv2blEsjsyX75IGF446+JJgIQa
         OSbjGH7FsBnSlMlzJpGiMOsnLzJ06BriR8pGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317440; x=1702922240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ+R8B3wHCuWt284dmb9Of0onfh+d3cgp76iNW/6Qqk=;
        b=euvTKtZ0UGlS0VaaJPnhiqI4Vim2H5tvj7k8podyz/xT+mZzybE9aTXFSlEtd4ste/
         I2iRxorKYYRUTL3Upubl9/ZFPxY+2EjNveoJ9FgkjZHAE+Lw/JAOb2fkpdKzwRTrAlBz
         9bmuLH6zqbGB7OgfeBYM1rCqFQoIZBcPF3YRX3kOK8MlVd6lnq+GLxfxfG54Iopr6apn
         0D4yKbXfCB2uQQwRjmFmzPW4lFSvmHGY1rfx5DQ3eHAB2rcwmPr1aS26fRK857tWkoGj
         IBHyTcYEYGM3g1oD4Qy1CC1qGzqddR4RljrKt7plRo5oZ1OUx+osw9Rz7YCFpDAPdfJL
         CVXQ==
X-Gm-Message-State: AOJu0YxOGcgo5aysjMlRgPNkKzP7iU3pzHwK8FclEzw44+owSSFMi32y
	ru+RwJbr1n8Q9rOcdHy5Bpz1sg==
X-Google-Smtp-Source: AGHT+IHhS8zwI1NybzNdNGlVlhUK2j8AuOrYo5xAxBVkRUX7U4OlrMBon1SmCu4zLgRRSqo6ThubwA==
X-Received: by 2002:a05:600c:1ca3:b0:40c:243d:daa6 with SMTP id k35-20020a05600c1ca300b0040c243ddaa6mr1570231wms.8.1702317440373;
        Mon, 11 Dec 2023 09:57:20 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b003334520e49bsm9101723wrw.53.2023.12.11.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:57:19 -0800 (PST)
Date: Mon, 11 Dec 2023 18:57:19 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
	Alex Deucher <Alexander.Deucher@amd.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
	Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
	Honglei Huang <Honglei1.Huang@amd.com>,
	Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <ZXdNf0HWs4nAVPeF@macbook>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210161519.1550860-4-Jiqian.Chen@amd.com>

On Mon, Dec 11, 2023 at 12:15:19AM +0800, Jiqian Chen wrote:
> There is a need for some scenarios to use gsi sysfs.
> For example, when xen passthrough a device to dumU, it will
> use gsi to map pirq, but currently userspace can't get gsi
> number.
> So, add gsi sysfs for that and for other potential scenarios.
> 
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  drivers/acpi/pci_irq.c  |  1 +
>  drivers/pci/pci-sysfs.c | 11 +++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 630fe0a34bc6..739a58755df2 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  		kfree(entry);
>  		return 0;
>  	}
> +	dev->gsi = gsi;

It would be better if the gsi if fetched without requiring calling
acpi_pci_irq_enable(), as the gsi doesn't require the interrupt to be
enabled.  The gsi is known at boot time and won't change for the
lifetime of the device.

>  
>  	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
>  	if (rc < 0) {
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..c51df88d079e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -71,6 +71,16 @@ static ssize_t irq_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(irq);
>  
> +static ssize_t gsi_show(struct device *dev,
> +			struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);

const

Thanks, Roger.

