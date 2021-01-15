Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8C2F7127
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 04:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbhAODty (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 22:49:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:53969 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbhAODty (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 22:49:54 -0500
IronPort-SDR: QqFEGtEaJcrIwAc6syNn3+VwAWqoEH0XoWA50lB24uGbczzj+/mNNXUgrgLgS2RsMvDcvFBcab
 NfJe7DRUyNjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178578736"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="178578736"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 19:49:13 -0800
IronPort-SDR: nI0l5cZaUWU+Zsj5BL+QF2TfJ3e47MPhnHfVJjuGJI9tho79G3WwYJKX/20HkGgLht1PMQ2MYs
 MMpG/ZC+NA+g==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382513151"
Received: from yulungsu-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.129.206])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 19:49:13 -0800
Date:   Thu, 14 Jan 2021 19:49:11 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>
Subject: Re: ACPI Working Group Code First ECR for a new CXL Root Object
Message-ID: <20210115034911.nkgpzc756d6qmjpl@intel.com>
References: <ecfd911dc8b9a5bac89d1de68047400d15525232.camel@intel.com>
 <ab06ae5c27a222ec261195e291ecadf655aedeb2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab06ae5c27a222ec261195e291ecadf655aedeb2.camel@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21-01-14 19:17:52, Verma, Vishal L wrote:
> On Thu, 2020-12-03 at 20:12 +0000, Verma, Vishal L wrote:
> > This is a public RFC of an ACPI proposal to add a new CXL Root Object
> > that indicates the presence of a CXL hierarchy. The proposal is being
> > made in the new 'Code First' workflow of the ACPI Spec Working Group.
> > The subject matter here has been explored in previously posted patches
> > to QEMU[1] as well as Linux[2]. These patches have served as a proof-of-
> > concept test vehicle to help ensure that the proposal works in practice.
> > The cover letter in series [2] goes into additional detail (section
> > titled 'ACPI0017') for the reasoning behind the proposal, and what is
> > needed beyond what's described in the CXL 2.0 spec.
> >
> > The change proposal that follows is in markdown format.
> >
> > [1]: https://lore.kernel.org/qemu-devel/20201111054724.794888-1-ben.widawsky@intel.com/
> > [2]: https://lore.kernel.org/linux-cxl/20201111054356.793390-1-ben.widawsky@intel.com/
> >
> > ----
> >
> > # Title: Add CXL Root Object _HID
> >
> > # Status: Draft
> 
> This ECR was approved in the ASWG today without any modifications, and
> this content can be expected to be present in the next release of the
> specification.
> 

Nice job Vishal!

> >
> > # Document: ACPI Specification 6.4
> >
> > # License
> > SPDX-License Identifier: CC-BY-4.0
> >
> > # Submitter:
> > * Sponsor: Vishal Verma, Intel
> > * Creators/Contributors:
> >     * Chet Douglas, Intel
> >     * Ben Widawsky, Intel
> >     * Dan Williams, Intel
> >     * Vishal Verma, Intel
> >
> > # Summary of the Change
> > Add “Compute Express Link Root Object” enumeration value to the ACPI
> > Device IDs Table (5.160).
> >
> > # Benefits of the Change
> > Compute Express Link (CXL) is a new high-speed CPU-to-Device and CPU-to-
> > Memory interconnect. The new ACPI Device ID represents a singleton
> > device that allows the OSPM to trigger the enumeration of the CXL.mem
> > address space, and indicates the presence of cross Host Bridge
> > (ACPI0016) interleaved CXL.mem resources.
> >
> > # Impact of the Change
> > One new row added to the ACPI Device IDs table (5.160).
> >
> > # References
> > * Compute Express Link Specification v2.0,
> > <https://www.computeexpresslink.org/>
> >
> > # Detailed Description of the Change
> >
> > Add “Compute Express Link Root Object” enumeration device
> >
> > ### 5.6.7 Device Class-Specific Objects
> >
> > Most device objects are controlled through generic objects and  ...
> >
> > Table 5.160 ACPI Device IDs
> >
> > > Value | Description |
> > > :--- | :---: | :---: | :--------------------------- |
> > > .. | .. |
> > > ACPI0017 | **Compute Express Link Root Object:** This device
> > represents the root of a CXL capable device hierarchy. It shall be
> > present whenever the platform allows OSPM to dynamically assign CXL
> > endpoints to a platform address space. |
> >
> > ## Special Instructions
> 
