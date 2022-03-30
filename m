Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A24ECCD8
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Mar 2022 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbiC3TDi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Mar 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346534AbiC3TDc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Mar 2022 15:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F36B3E0E4;
        Wed, 30 Mar 2022 12:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A8F613F5;
        Wed, 30 Mar 2022 19:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB63C340EE;
        Wed, 30 Mar 2022 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648666906;
        bh=O0fJh/tHTFLogWD/VMIkY1x8ShZZhrgVVXKld6y2H2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g8qSsfDnmeUTO+ipn7BJ3nEz3q7aX7jp339ntNuF/O9qIEuVYgC/DqH2K3mN4nMWX
         NcYR6AYyr7bM1CDRL5B9WRSx12xtrI6YAhQutqZWXOih/vH3wOm3HYfSfSJyBDe6L5
         Le/tuMeD6AMJcEpfe0spbHrhS+wm+pFzpg/BK6MhAj6sCXRhBrZHOOwtIzGXkYAf7L
         uMmL88IcM3DNuYGEwzyVHp1KiQLM3j3aTwMtUZiXUuErFGpdY8Ucr3hTEj1e83N/KT
         xSrqTABg8TkM0Ma59jlN3Z4LojTbTvJ9435FmEVFEliJmwRegz4YC1Gg/z6ycCq2uP
         lZHX3TRRRHlpg==
Date:   Wed, 30 Mar 2022 14:01:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 3/3] acpi/pci_root: negotiate CXL _OSC
Message-ID: <20220330190142.GA1698903@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330181434.1515791-4-vishal.l.verma@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Don't just make up new prefixes for the subject line.  Previous ones
look like this:

  PCI/ACPI: Fix acpi_pci_osc_control_set() kernel-doc comment
  ACPI: Use acpi_fetch_acpi_dev() instead of acpi_bus_get_device()
  PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()
  PCI/ACPI: Move _OSC query checks to separate function
  PCI/ACPI: Move supported and control calculations to separate functions
  PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
  ACPI: pci_root: Unify the message printing
  PCI/ACPI: Clarify message about _OSC failure
  PCI/ACPI: Remove unnecessary osc_lock
  PCI/ACPI: Make acpi_pci_osc_control_set() static
  PCI/ACPI: Replace open coded variant of resource_union()

So I think "PCI/ACPI: " would be a good choice.  Also capitalize the
next word as all the above do.

On Wed, Mar 30, 2022 at 12:14:34PM -0600, Vishal Verma wrote:
> Add full support for negotiating _OSC as defined in the CXL 2.0 spec, as

Please include a section reference.

> applicable to CXL-enabled platforms. Advertise support for the CXL
> features we support - 'CXL 2.0 port/device register access', 'Protocol
> Error Reporting', and 'CL Native Hot Plug'. Request control for 'CXL

"CL" looks like a typo for "CXL"?

> Memory Error Reporting'. The requests are dependent on CONFIG_* based
> pre-requisites, and prior PCI enabling, similar to how the standard PCI

s/pre-requisites/prerequisites/

> _OSC bits are determined.
> 
> The CXL specification does not define any additional constraints on
> the hotplug flow beyond PCIe native hotplug, so a kernel that supports
> native PCIe hotplug, supports CXL hotplug. For error handling protocol
> and link errors just use PCIe AER. There is nascent support for
> amending AER events with CXL specific status [1], but there's
> otherwise no additional OS responsibility for CXL errors beyond PCIe
> AER. CXL Memory Errors behave the same as typical memory errors so
> CONFIG_MEMORY_FAILURE is sufficient to indicate support to platform
> firmware.
> 
> [1]: https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>

What was reported by the robot?  If it just complained about something
in v1 or v2, I think there's no point in mentioning this here.  It's
the same as ordinary review comments (like these I'm composing), and
they don't need to be acknowledged.  I think "Reported-by" is great
when giving credit for bug fixes, but that's not what's happening
here.

Bjorn
