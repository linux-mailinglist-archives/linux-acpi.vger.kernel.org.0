Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05335C7BB
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhDLNee (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 09:34:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2837 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhDLNee (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 09:34:34 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJqMC039Mz689Lf;
        Mon, 12 Apr 2021 21:28:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 15:34:08 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 14:34:08 +0100
Date:   Mon, 12 Apr 2021 14:32:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Douglas, Chet R" <chet.r.douglas@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [ACPI Code First ECN v2]: Generic Port, performace data for
 hotplug memory
Message-ID: <20210412143241.00005521@Huawei.com>
In-Reply-To: <e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com>
References: <e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 10 Apr 2021 05:34:29 +0000
"Williams, Dan J" <dan.j.williams@intel.com> wrote:

> Changes since v1 [1]:
>   * Rename Generic Target to Generic Port and make a new distinct SRAT
>     type independent of Generic Initiator (Jonathan)
>   * Clarify that this new "Port" concept is not limited to CXL. It is a
>     generic way to describe the performance of static paths to
>     dynamically added system memory (Mahesh)
>   * Fixes and cleanups (Chet)
> 
> [1]: 
> http://lore.kernel.org/r/CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com

Hi Dan,

I'm fine with the actual changes.  A few editorial suggestions inline.

Description wise, it rightly focuses on the case of memory on CXL.
I'm a little worried people might miss the fact it enables the other
direction, e.g. GI on CXL accessing system memory. Perhaps that needs
calling out a little more in the intro?

> 
> ---
> 
> While the platform BIOS is able to describe the performance
> characteristics of CXL memory that is present at boot, it is unable to
> statically enumerate the performance of CXL memory hot inserted
> post-boot. The OS can enumerate most of the characteristics from link
> registers and CDAT, but the performance from the CPU to the host
> bridge, for example, is not enumerated by PCIE or CXL. Introduce an
> ACPI mechanism for this purpose.
> 
> ---
> 
> # Title: Introduce a Generic Port for hotplug memory buses like CXL
> 
> # Status: Draft v2
> 
> # Document: ACPI Specification 6.4
> 
> # License
> SPDX-License Identifier: CC-BY-4.0
> 
> # Submitter:
> * Sponsor: Dan Williams, Intel
> * Creators/Contributors:
>     * Mahesh Natu, Intel
>     * Chet Douglas, Intel
>     * Deepak Shivakumar, Intel
>     * Jonathan Cameron, Huawei
> 
> # Changes since v1
>   * Rename Generic Target to Generic Port and make a new distinct SRAT
>     type independent of Generic Initiator (Jonathan)
>   * Clarify that this new "Port" concept is not limited to CXL. It is a
>     generic way to describe the performance of static paths to
>     dynamically added system memory (Mahesh)
> 
> # Summary of the Change
> Introduce a new "Generic Port" type to the SRAT to describe the
> performance from CPU and other initiator domains to the root of a CXL
> topology, or any other topology that might dynamically add system memory
> behind the "Port". This is in support of, but not limited to, the OS
> being able to enumerate the performance topology for dynamically added /
> discovered CXL Memory Device endpoints.
> 
> # Benefits of the Change
> Consider the case of a system with a set of CXL Host Bridges (ACPI0016),
> and some endpoints attached at boot. In that scenario the platform
> firmware is able to enumerate those devices, enumerate and map CXL
> memory into the system physical memory address space, and generate the
> typical static SRAT/SLIT/HMAT set of tables describing CXL attached
> memory. Now, consider the case where devices are dynamically added and
> enumerated post boot, i.e. post generation of the static memory tables.
> In this scenario platform firmware is unable to perform the end-to-end
> enumeration necessary to populate SRAT and HMAT for the endpoints that
> may be hot-inserted behind those bridges post power-on. The
> address-range is unknown so SRAT can not be pre-populated in the typical
> way that hotplug system memory is enumerated. Even if a static address
> range was set aside for future hotplug the performance is unknown (no
> CDAT nor interleave configuration) so HMAT can not be pre-populated.
> 
> However, what is known to platform firmware that generates the
> SRAT/SLIT/HMAT and is the performance characteristics of the path

HMAT is (drop the and)

> between CPU and Generic Initiators to the Generic Port (e.g. CXL Host
> Bridge). With the addition of a Generic Port proximity domain to the

Generic Port Affinity Structure

> SRAT then the SLIT and HMAT can enumerate the platform-static component
> of a given edge in the platform-performance topology graph. It enables
> the OS to build out a performance mapping for system memory address
> ranges dynamically discovered, or provisioned, behind a Generic Port.
> The OS mapping takes into account the Generic Port performance (as
> either an initiator or a target), the interleave configuration, and the
> bus enumerable performance characteristics (link latency, bandwidth,
> switch traversals) to supplement the static HMAT data enumerated at
> boot.
> 
> # Impact of the Change
> A new SRAT type requires non-conforming system software to ignore the
> new type in the SRAT, ignore any coordinate in the SLIT that includes
> the associated port's proximity domain, and ignore any coordinate in the
> HMAT that includes the port's proximity domain as either an initiator or
> a target.

Rereading the following comments after writing them, I think we are probably best
just ignoring the corners it refers to, but have left it here in case it comes up in
discussions.

Initially I wondered if we needed a note here to explain that we don't
need an explicit (i.e. _OSC) way to discover support for Generic Ports
because we don't expect to run into the issue with _PXM results in DSDT
needing to be modified based on that support (as we don't expect _PXM
to ever refer to a proximity domain containing only a Generic Port).

Perhaps that is somewhat of a backwards argument.  Does it
make sense to add the constraint that a proximity domain when it only
contains a Generic Port should not be used in _PXM?
"
6.2.14 _PXM (Proximity)
This optional object is used to describe proximity domain associations
within a machine. _PXM evaluates to an integer that identifies a device
as belonging to a Proximity Domain defined in the System Resource
Affinity Table (SRAT).
"

Now it's already possible to use Affinity structures in SRAT to define
domains that will result in craziness.  E.g. an ITS that is in a domain
on it's own.  So perhaps this isn't the time to make that more explicit.

> 
> In contrast, conforming system software need only consult the Generic
> Port data to optionally extend the enumeration and distinguish Port
> attached initiators and memory targets from the existing set of
> enumerated proximity domains.
> 
> A conforming implementation also has the option to ignore the Generic Port
> contribution to the performance,
> 
> in either a row, or col  to be considered by system software that parses

Odd line break above and sentence doesn't parse.  Editing issue perhaps?

> SRAT, SLIT, and HMAT. Given that the OS still needs to dynamically
> enumerate and instantiate the memory ranges and initiators behind the
> Generic Port.

"Given" suggests something as a result of, or perhaps the intent here
"Given that, the OS..."

> The assumption is that operating systems that do not
> support native CXL enumeration will ignore this data in the HMAT, while
> CXL native enumeration aware environments will use this fragment of the
> performance path to calculate the performance characteristics.
> 
> # References
> * Compute Express Link Specification v2.0,
> <https://www.computeexpresslink.org/>
> 
> # Detailed Description of the Change
> 
> * Section 5.2.16 System Resource Affinity Table (SRAT) add another
>   bullet for Generic Ports:
> 
> 	* generic ports (e.g. host bridges that can dynamically discover
> 	  new initiators and instantiate new memory range targets)

That implies the host bridge is responsible for the work of discovering
the initiators and memory range targets.  Perhaps reword along the lines of

e.g. host bridges beyond which new initiators and memory range targets
may be dynamically discovered.

> 
> * Add new section 5.2.16.7 Generic Port Affinity Structure:
>   The Generic Port Affinity Structure provides an association between a
>   proximity domain number and a device handle representing a Generic
>   Port (e.g. CXL Host Bridge, or similar device that hosts a dynamic
>   topology of memory ranges and/or initiators).
> 
>   Support of Generic Port Affinity Structures by an OSPM is optional.
> 
> * Add a table describing the Generic Port Affinity Structure (Table
>   5.xx):
> 
> 
> | Field  | Byte Length | Byte Offset | Description                  |
> | :----- | :---        | :---        | :--------------------------- |
> | Type   | 1           | 0           | 6 Generic Port Structure     |
> | Length | 1           | 1           | 32                           |
> | Reserved | 1         | 2           | Reserved and must be zero    |
> | Device Handle Type | 1 | 3 | Device Handle Type: See 5.2.16.6 Generic Initiator Affinity Structure for the possible device handle types and their format. |
> | Proximity Domain | 4 | 4 | The proximity domain to identify the performance of this port in the HMAT. |

Perhaps make that vague to allow for SLIT as well?  I'd imagine any sane
OS will rely on HMAT being available but that constraint doesn't exist yet
in the ACPI spec (I wish it did!)

> | Device Handle | 16   | 8           | Device Handle of the Generic Port, see Table 5.57 and 5.58 for a description of this field. |
> | Flags  | 4           | 24          | See table 5.59 for a description of this field. |
> | Reserved | 4         | 28          | Reserved and must be zero.   |
> 
> * Replace all instances of "Initiator" with "Initiator / Port" in "Table
>   5.59 Flags - Generic Initiator Affinity Structure", including the
>   table name.

Looks to me like all the text around HMAT and SLIT is 'broad' enough that we don't
need to modify anything there which definitely makes this a cleaner change than
I expected.

Good stuff,

Jonathan

