Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9420B5E3
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgFZQ3o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 12:29:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:12124 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgFZQ3o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jun 2020 12:29:44 -0400
IronPort-SDR: OhFM+fSl3n9XzoBpKuRE8MhNU0f7/WSXbO+niRi867S145Be1k5WNACn3bK9oLjGYr7sNadLjy
 hGJej+Y4K+Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="146885419"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="146885419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 09:29:35 -0700
IronPort-SDR: WAhQgrsX0X2+h5wxtDsZdm10v9nP1/snxCdTmHTFh/Y9C8A5DVxD1wx6J0y7HyR12d0cNHDUUI
 YNGF4wR7wwhQ==
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="480052352"
Received: from mayahill-mobl.amr.corp.intel.com (HELO [10.251.140.177]) ([10.251.140.177])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 09:29:34 -0700
From:   "Sean V Kelley" <sean.v.kelley@linux.intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Add support for reset of RCiEPs for
 APEI/Firmware first reporting only
Date:   Fri, 26 Jun 2020 09:29:34 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <02999929-39F5-4A11-AACA-84490F12E12B@linux.intel.com>
In-Reply-To: <20200622114402.892798-1-Jonathan.Cameron@huawei.com>
References: <20200622114402.892798-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


On 22 Jun 2020, at 4:44, Jonathan Cameron wrote:

> Was previously: PCI/AER: Add partial initial supprot for RCiEPs using 
> RCEC or
> firmware first.
>
> Currently the kernel does not handle AER errors for Root Complex 
> integrated
> End Points (RCiEPs)[0].  These devices sit on a root bus within the 
> Root Complex
> (RC).  AER handling is performed by a Root Complex Event Collector 
> (RCEC) [1]
> which is a effectively a type of RCiEP on the same root bus.
>
> This code will only perform the correct reset flow for the case where 
> there
> is no need to take any actions on the RCEC because the firmware is
> responsible for them.   This is true where APEI [2] is used to report 
> the AER
> errors via a GHES[v2] HEST entry [3] and relevant AER CPER record [4] 
> and Firmware
> First handling is in use.

Right, in the case of the RCEC one identifies the RCiEPs by the RCiEP 
bitmap as a part of the RCEC Associated Endpoint Extended Capabilities.  
This ‘search’ so to speak would make use also of the RCEC Associated 
Bus Numbers Register to associate the devices with an RCEC when not on 
the same bus.

>
> As there is no current RCEC driver support, it should not be possible 
> to get
> to this code via any routes other than the one above. Hence 
> appropriate RCEC
> handling can be added when the RCEC driver support is ready.


>
> The error handling is different from a normal PCIe End Point because:
>
> 1) There is no downstream port above an RCiEP as these devices sit on 
> a root
>    bus.
>
> 2) In general, it makes little sense to reset other devices on on the 
> same
>    root bus.  For error handling outside the of the root complex (RC) 
> an AER
>    error will indicate that all the topology below the physical link, 
> which
>    the error is related to, will need to be reset as they share a 
> common
>    path to the host.  For an RCiEP there is no such defined shared 
> path
>    relationship with other elements on the root bus.
>
> A new walk function, similar to pci_bus_walk is provided that takes a 
> pci_dev
> instead of a bus.  If that dev corresponds to a downstream port it 
> will walk
> the subordinate bus of that downstream port.  If the dev does not then 
> it
> will call the function on that device alone.   This function allows us 
> to
> avoid adding special cases to the majority of the error handling.

Then in that case the callback could add the additional checks specific 
to identifying the associated RCiEPs.

>
> Open questions:
>
> 1. Are we better protecting against link reset for an RCiEP in here or
>    should we put the check in the link reset functions?
>
> 2. If we were to get a stupid firmware record with the relevant reset 
> flag
>    set to trigger a link reset, what is the correct response?  For now 
> I
>    try to report that we haven't done anything and print a warning.
>
> 3. Naming of pci_walk_below_dev is rather unsatisfying. Any better 
> ideas?
>
> 4. pci_walk_below_dev is perhaps not of general utility. Shall I make 
> it local
>    in err.c?  If not would a precursor patch for that be preferred?’

It depends.  Is it intended as a drop in replacement where needed for 
pci_walk_bus()? So in that case you are now passing the dev structure 
and do the check for subordinate or is it intended as being specific to 
say RCEC? With AER, one could either first check for RC_EC type before 
using this one.  Or one could just drop in replace (passing the dev 
structure instead) and the call back performs the RCEC specific checks 
when a device is encountered.

>
> Testing has been performed via error injection on a QEMU platform as 
> that lets
> me create a wide range of topologies and report errors at any chosen 
> location.
> Currently I have no plans to upstream this injection support, but am 
> happy to
> share if useful to others.

I’m experimenting with it in my RCEC code in AER and will give you 
additional feedback.

Thanks,

Sean


>
> [0] ACPI PCI Express Base Specification 4.0 1.3.2.3 Root Complex 
> Integrated
>     Endpoint Rules.
> [1] ACPI PCI Express Base Specification 4.0 6.2 Error Signalling and 
> Logging
> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface 
> (APEI)
> [3] ACPI Sepcification 6.3 18.2.3.7 Generic Hardware Error Source
> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes since v1:
> * Separated from the largely unrelated fix so the two can move 
> forwards separately.
> * Instead of separate path for RCiEP handling use the method suggested 
> by Bjorn
>   and Sathyanarayanan with an adjusted pci_bus_walk.
>
> Thanks all for reviews of V1.
>
>  drivers/pci/bus.c      | 28 ++++++++++++++++++++++++++++
>  drivers/pci/pcie/err.c | 29 +++++++++++++++++++----------
>  include/linux/pci.h    |  2 ++
>  3 files changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8e40b3e6da77..7cbe1ed2db3d 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -411,6 +411,34 @@ void pci_walk_bus(struct pci_bus *top, int 
> (*cb)(struct pci_dev *, void *),
>  }
>  EXPORT_SYMBOL_GPL(pci_walk_bus);
>
> +/** pci_walk_below_dev - walk devices below (or on) another device
> + *  @dev      device for which we should walk below, include device 
> when not a port.
> + *  @cb       callback to be called for each device found
> + *  @userdata arbitrary pointer to be passed to callback.
> + *
> + *  If the device provided is a port,
> + *  walk the subordinate bus, including any bridged devices
> + *  on buses under this bus.  Call the provided callback
> + *  on each device found.
> + *
> + *  If the device provided hs no subordinate bus, call the provided
> + *  callback on the device itself.
> + *
> + */
> +void pci_walk_below_dev(struct pci_dev *dev, int (*cb)(struct pci_dev 
> *, void *),
> +			void *userdata)
> +{
> +	struct pci_bus *bus;
> +
> +	if (dev->subordinate) {
> +		bus = dev->subordinate;
> +		pci_walk_bus(bus, cb, userdata);
> +	} else {
> +		cb(dev, userdata);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_walk_below_dev);
> +
>  struct pci_bus *pci_bus_get(struct pci_bus *bus)
>  {
>  	if (bus)
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..fa08b1cc3d96 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -151,33 +151,39 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
> *dev,
>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> -	struct pci_bus *bus;
>
>  	/*
>  	 * Error recovery runs on all subordinates of the first downstream 
> port.
>  	 * If the downstream port detected the error, it is cleared at the 
> end.
> +	 * For RCiEPs we should reset just the RCiEP itself.
>  	 */
>  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END))
>  		dev = dev->bus->self;
> -	bus = dev->subordinate;
>
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
> -		pci_walk_bus(bus, report_frozen_detected, &status);
> +		pci_walk_below_dev(dev, report_frozen_detected, &status);
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +			pci_warn(dev, "link reset not possible for RCiEP\n");
> +			status = PCI_ERS_RESULT_NONE;
> +			goto failed;
> +		}
> +
>  		status = reset_link(dev);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
>  		}
>  	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
> +		pci_walk_below_dev(dev, report_normal_detected, &status);
>  	}
>
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
> -		pci_walk_bus(bus, report_mmio_enabled, &status);
> +		pci_walk_below_dev(dev, report_mmio_enabled, &status);
>  	}
>
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> @@ -188,17 +194,20 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
> *dev,
>  		 */
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast slot_reset message\n");
> -		pci_walk_bus(bus, report_slot_reset, &status);
> +		pci_walk_below_dev(dev, report_slot_reset, &status);
>  	}
>
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>
>  	pci_dbg(dev, "broadcast resume message\n");
> -	pci_walk_bus(bus, report_resume, &status);
> +	pci_walk_below_dev(dev, report_resume, &status);
>
> -	pci_aer_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		pci_aer_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c79d83304e52..538bf0a76d33 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1411,6 +1411,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct 
> pci_dev *dev, int max,
>
>  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, 
> void *),
>  		  void *userdata);
> +void pci_walk_below_dev(struct pci_dev *dev, int (*cb)(struct pci_dev 
> *, void *),
> +			void *userdata);
>  int pci_cfg_space_size(struct pci_dev *dev);
>  unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
> -- 
> 2.19.1
