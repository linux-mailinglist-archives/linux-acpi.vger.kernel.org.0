Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299721782BC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2020 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgCCTEK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Mar 2020 14:04:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42673 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgCCTEK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 14:04:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so4132530otd.9;
        Tue, 03 Mar 2020 11:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0WOeb4baq2hEiZkRVACn+zkObdPLKsAV8wkGaqGZrM=;
        b=KQCs3cHUVB2gBVwg8lzA85QRPW3pzzalYryLsKk2R8zG/hhlvwkQht2cUCoeZywe71
         hbZeyBlKWtxhTlRQgqd2Tgys0RRYdXB/CwxR8hSqSv67ZtKJtHsV9DKGAsm2E1dgejNK
         3bKdZQzvJaNPuRjFndzlTMpHHY+Y6FIr/jNSKO1SBLMeGVsUD92oiByZwo4FfPwVOQch
         3Mjm/l0bMuHHuuoFTPfFMPSSBh/qq+vBpYDy0fEo4Qb6ds0nokWkGMlrIqeOKUBuxCl5
         RWmYsyeq7YN6o1NYRECwTHvUqqmmDTSL2X0ES/A2PuhJqTlY1Xbr1dX7BP56b6OpY/N3
         Q5kw==
X-Gm-Message-State: ANhLgQ2A2y8WK6srNwc6HSYUMtgkc9HIKP5ai82804hMJ0OyWdbECgqf
        bvToqL5WrDTm4sYqeCHwicN3CeAeiEvbT3W6mzY=
X-Google-Smtp-Source: ADFU+vtcWO4c/SOfO2RAmjHhPpxFmxRdzHxMH9EOqVbLXmZOr66I92JbG54xfgcxTaFrpmLYJyCTNHz1XUiwdZFLJRE=
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr4306802otp.189.1583262248022;
 Tue, 03 Mar 2020 11:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20200303132852.13184-1-stanspas@amazon.com> <20200303132852.13184-8-stanspas@amazon.com>
In-Reply-To: <20200303132852.13184-8-stanspas@amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Mar 2020 20:03:56 +0100
Message-ID: <CAJZ5v0gD4XweLHQzQfRiBxWz8O5mFsc5Chj4JNhX+5ja6Cxrig@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] PCI: Clean up and document PM/reset delays
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Stanislav Spassov <stanspas@amazon.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 3, 2020 at 2:30 PM Stanislav Spassov <stanspas@amazon.com> wrote:
>
> From: Stanislav Spassov <stanspas@amazon.de>
>
> ...and replace several "magic numbers" scattered throughout the code.

What "magic numbers" exactly do you mean?  The SRIOV and FLR delays?
Why not to be more specific here if so?

> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  drivers/pci/controller/pci-aardvark.c |  2 +-
>  drivers/pci/controller/pci-mvebu.c    |  2 +-
>  drivers/pci/iov.c                     |  4 +-
>  drivers/pci/pci-acpi.c                |  4 +-
>  drivers/pci/pci.c                     | 21 ++------
>  drivers/pci/pci.h                     | 72 +++++++++++++++++++++++++--
>  6 files changed, 80 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 2a20b649f40c..2ece24abf751 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -344,7 +344,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>          * fundamental reset. As required by PCI Express spec a delay for at
>          * least 100ms after such a reset before link training is needed.
>          */
> -       msleep(PCI_PM_D3COLD_WAIT);
> +       msleep(PCI_RESET_DELAY);
>
>         /* Start link training */
>         reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 153a64676bc9..c1cd1b7cf7ee 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -927,7 +927,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
>                 return ret;
>
>         if (port->reset_gpio) {
> -               u32 reset_udelay = PCI_PM_D3COLD_WAIT * 1000;
> +               u32 reset_udelay = PCI_RESET_DELAY * 1000;
>
>                 of_property_read_u32(port->dn, "reset-delay-us",
>                                      &reset_udelay);
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4d1f392b05f9..d4e4a0c0a97f 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -524,7 +524,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>         iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>         pci_cfg_access_lock(dev);
>         pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> -       msleep(100);
> +       msleep(PCI_VF_ENABLE_DELAY);
>         pci_cfg_access_unlock(dev);
>
>         rc = sriov_add_vfs(dev, initial);
> @@ -735,7 +735,7 @@ static void sriov_restore_state(struct pci_dev *dev)
>         pci_iov_set_numvfs(dev, iov->num_VFs);
>         pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>         if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
> -               msleep(100);
> +               msleep(PCI_VF_ENABLE_DELAY);
>  }
>
>  /**
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b147b61c6668..0ece144ac9c5 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1242,7 +1242,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>                         value = (int)value_us / 1000;
>                         if ((int)value_us % 1000 > 0)
>                                 value++;
> -                       if (value < PCI_PM_D3COLD_WAIT)
> +                       if (value < PCI_RESET_DELAY)
>                                 pdev->d3cold_delay = value;
>                 }
>                 if (elements[3].type == ACPI_TYPE_INTEGER) {
> @@ -1250,7 +1250,7 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>                         value = (int)value_us / 1000;
>                         if ((int)value_us % 1000 > 0)
>                                 value++;
> -                       if (value < PCI_PM_D3_WAIT)
> +                       if (value < PCI_PM_D3HOT_DELAY)
>                                 pdev->d3_delay = value;
>                 }
>         }
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4899b12b5a38..aaef00578487 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2844,8 +2844,8 @@ void pci_pm_init(struct pci_dev *dev)
>
>         dev->pm_cap = pm;
>         dev->ignore_reset_delay_on_sx_resume = 0;
> -       dev->d3_delay = PCI_PM_D3_WAIT;
> -       dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
> +       dev->d3_delay = PCI_PM_D3HOT_DELAY;
> +       dev->d3cold_delay = PCI_RESET_DELAY;
>         dev->bridge_d3 = pci_bridge_d3_possible(dev);
>         dev->d3cold_allowed = true;
>
> @@ -4500,12 +4500,7 @@ int pcie_flr(struct pci_dev *dev)
>         if (dev->imm_ready)
>                 return 0;
>
> -       /*
> -        * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
> -        * 100ms, but may silently discard requests while the FLR is in
> -        * progress.  Wait 100ms before trying to access the device.
> -        */
> -       msleep(100);
> +       msleep(PCI_FLR_DELAY);
>
>         return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>  }
> @@ -4544,13 +4539,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>         if (dev->imm_ready)
>                 return 0;
>
> -       /*
> -        * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
> -        * updated 27 July 2006; a device must complete an FLR within
> -        * 100ms, but may silently discard requests while the FLR is in
> -        * progress.  Wait 100ms before trying to access the device.
> -        */
> -       msleep(100);
> +       msleep(PCI_FLR_DELAY);
>
>         return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
>  }
> @@ -4590,7 +4579,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>         csr &= ~PCI_PM_CTRL_STATE_MASK;
>         csr |= PCI_D3hot;
>         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> -       msleep(PCI_PM_D3_WAIT);
> +       msleep(PCI_PM_D3HOT_DELAY);
>
>         csr &= ~PCI_PM_CTRL_STATE_MASK;
>         csr |= PCI_D0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c4c3ba926f45..9b5dd6ea2f52 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -43,9 +43,75 @@ int pci_probe_reset_function(struct pci_dev *dev);
>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>  int pci_bus_error_reset(struct pci_dev *dev);
>
> -#define PCI_PM_D2_DELAY         200
> -#define PCI_PM_D3_WAIT          10
> -#define PCI_PM_D3COLD_WAIT      100
> +/*
> + * These constants represent the minimum amounts of time mandated by the
> + * PCI Express Base specification that software needs to wait after
> + * various PCI device events involving (re-)initialization. Only after
> + * the appropriate delay has elapsed, is software permitted to issue
> + * Configuration Requests targeting the affected device.
> + *
> + * Relevant sections in PCI Express Base Specification r5.0 (May 22, 2019):
> + * - 6.6.1 "Conventional Reset" for PCI_RESET_DELAY and PCI_DL_UP_DELAY
> + * - 6.6.2 "Function Level Reset" for PCI_FLR_DELAY
> + * - 5.9 "State Transition Recovery Time Requirements" for PCI_PM_D3HOT_DELAY
> + *        and PCI_PM_D2_DELAY
> + * - 9.3.3.3.1 "VF Enable" for PCI_VF_ENABLE_DELAY
> + *
> + * There are mechanisms to reduce some of the delay values for specific devices:
> + * - a device may expose the Readiness Time Reporting Extended Capability from:
> + *   PCI Express Base Specification r4.0 (September 27, 2017), sec 7.9.17
> + *   (This is currently not supported by the kernel.)
> + * - system firmware may provide overrides using an ACPI _DSM Function 9:
> + *   PCI Firmware Specification r3.2 (January 26, 2015), sec 4.6.9
> + *   (see pci_acpi_optimize_delay)
> + *
> + * Unless overridden by _DSM Function 9, other mechanisms may be used to reduce
> + * or completely avoid some of the delays:
> + * - Readiness Notifications (DRS and FRS)
> + * - the Immediate Readiness bit of the Status Register in the PCI header
> + * - the Immediate_Readiness_on_Return_to_D0 in the Power Management
> + *   Capabilities Register in the PCI Power Management Capability
> + * (None of these are currently supported by the kernel.)
> + *
> + * Note: While devices are required to be responsive to Configuration
> + * Requests after these delays, they may not respond with Successful
> + * Completion status until they complete potentially lengthy internal
> + * initialization sequences. Instead, devices respond with Configuration
> + * Request Retry Status (CRS) Completions. Therefore, additional waiting
> + * is necessary as handled by pci_dev_wait().
> + */
> +/*
> + * Conventional (non-FLR) reset delay, including D3cold->D0 transitions,
> + * Secondary Bus Reset, and any platform-specific means of triggering
> + * a Conventional Reset.
> + *
> + * According to PCI Firmware spec r3.2, sec 4.6.9, for devices beneath
> + * downstream ports supporting the Data Link Layer Active Reporting
> + * capability, this delay should not be used (see PCI_DL_UP_DELAY).
> + */
> +#define PCI_RESET_DELAY                100
> +/*
> + * Post-DL_Up (Data Link Layer Active) delay applicable for devices immediately
> + * under a Downstream Port that is capable of reporting Data Link Layer Ready.
> + * Not to be confused with how much time it takes for the link itself to become
> + * active (see pcie_wait_for_link_delay).
> + */
> +#define PCI_DL_UP_DELAY                100
> +/*
> + * Post-FLR delay
> + * Also applies to legacy devices supporting AF_FLR per Advanced Capabilities
> + * for Conventional PCI ECN, 13 April 2006, updated 27 July 2006)
> + */
> +#define PCI_FLR_DELAY          100
> +/*
> + * D0/D1/D2->D3hot and D3hot->D0 delay
> + * The specifications do *not* mention overridability of the ->D3hot direction
> + */
> +#define PCI_PM_D3HOT_DELAY     10
> +/* Post-VF_Enable delay */
> +#define PCI_VF_ENABLE_DELAY    100
> +/* D0/D1->D2 and D2->D0 delay */
> +#define PCI_PM_D2_DELAY                200
>
>  /**
>   * struct pci_platform_pm_ops - Firmware PM callbacks
> --
> 2.25.1
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
