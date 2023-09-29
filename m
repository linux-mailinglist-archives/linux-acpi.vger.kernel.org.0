Return-Path: <linux-acpi+bounces-297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D17B3C9A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0C51A282335
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949B67BE0
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 22:31:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AA9CA5B
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 20:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A629C433C7;
	Fri, 29 Sep 2023 20:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696019556;
	bh=4Y7NSZZJOmT/eG+oxY8xXIFK57w1o2IOQip+sUAH/DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=l34TBrW2MrrwJcVoPI1pUTZfB1TH4C5SQMIgIOIk4QK4dBOLXKObws4rfJ8aVMJhf
	 NdFRUkZM9NzIcfLSywBOLIBkgVadAd6VOoAcdq+fC8mPPoxnY5vSO9FBPu2o2PQei2
	 Yc9Lia4ss7tXxwZ2z0K+GZjVYI+R/F1cNAOpcdk2u7zpjlbe/ms4ZxukwOjDhK2fpP
	 xB/LmaI3iUPMXwR5WxudA2wA64UN6ik6RxCtMLEKs5882z/kYFMhM9w5MG4ZMLmp+0
	 OQR1FsLod1Vqbbrmo/YU/+GlUpYm8j5Zy6Gu716ko2PhSmamJxEo/eO6zTJIJ3bMMO
	 somZ7DZyLOtkw==
Date: Fri, 29 Sep 2023 15:32:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: D Scott Phillips <scott@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Darren Hart <darren@os.amperecomputing.com>,
	patches@amperecomputing.com
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
Message-ID: <20230929203234.GA552475@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j9hvhboyfmgs1CXkUqpmrMryNjwWGV+kJB-FCMfXaM_g@mail.gmail.com>

On Fri, Sep 29, 2023 at 09:06:02PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 28, 2023 at 5:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
> > > On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
> > > also present to request system firmware control of attention LEDs. Add an
> > > ACPI PCI Hotplug companion driver to support attention LED control.

> > > +static int __init acpiphp_ampere_altra_init(void)
> > > +{
> > > +     struct fwnode_handle *fwnode;
> > > +     acpi_handle leds_handle = NULL;
> > > +     struct acpi_device *leds;
> > > +     acpi_status status;
> > > +     int ret;
> > > +
> > > +     status = acpi_get_devices("AMPC0008", get_acpi_handle, NULL,
> > > +                               &leds_handle);
> >
> > Rafael, can you comment on whether we should use acpi_get_devices(),
> > acpi_bus_register_driver(), acpi_acpi_scan_add_handler(), or something
> > else here?
> 
> Personally, I would go for a platform driver, because the ACPI core
> should create a platform device for this object.
> 
> acpi_get_devices() carries out a namespace walk that is costly and
> entirely avoidable.
> 
> >  I try to avoid pci_get_device() because it subverts the
> > driver model (no hotplug support, no driver/device binding).
> >
> > I see Documentation/driver-api/acpi/scan_handlers.rst, but I'm not
> > clear on when to use acpi_bus_register_driver() vs
> 
> Never.
> 
> > acpi_acpi_scan_add_handler().
> 
> When you don't want the ACPI core to create a platform device for your
> ACPI device object.  There are cases like that, but they are rare.

Ah, so none of the above (not acpi_get_devices(),
acpi_bus_register_driver(), OR acpi_acpi_scan_add_handler()).

IIUC, what you propose would look something like this:

  static u32 led_service_id[4];

  static int altra_led_probe(struct platform_device *pdev)
  {
    struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);

    fwnode_property_read_u32_array(fwnode, "uuid", led_service_id, 4);
  }

  static const struct acpi_device_id altra_led_ids[] = {
    {"AMPC0008", 0}, {}
  };
  MODULE_DEVICE_TABLE(acpi, altra_led_ids);

  static struct platform_driver altra_led_driver = {
    .driver = {
      .acpi_match_table = altra_led_ids,
    },
    .probe = altra_led_probe,
  };
  module_platform_driver(altra_led_driver);

Bjorn

