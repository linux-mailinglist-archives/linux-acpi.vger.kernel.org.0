Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4863B42CE2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2019 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfFLRBH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jun 2019 13:01:07 -0400
Received: from foss.arm.com ([217.140.110.172]:57206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfFLRBH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jun 2019 13:01:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D8962B;
        Wed, 12 Jun 2019 10:01:06 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932E53F73C;
        Wed, 12 Jun 2019 10:01:05 -0700 (PDT)
Date:   Wed, 12 Jun 2019 18:00:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     Udit Kumar <udit.kumar@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Help on named object in kernel
Message-ID: <20190612170059.GA30299@e107155-lin>
References: <VI1PR04MB4640134AAE394D8063D9F04991EC0@VI1PR04MB4640.eurprd04.prod.outlook.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5E95B1@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C5E95B1@ORSMSX122.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 12, 2019 at 04:37:09PM +0000, Schmauss, Erik wrote:
> 
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Udit Kumar
> > Sent: Wednesday, June 12, 2019 4:48 AM
> > To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
> > Cc: lenb@kernel.org; Rafael J. Wysocki <rafael@kernel.org>
> > Subject: Help on named object in kernel
> > 
> > Dear ACPI experts,
> > I need your help on defining named objected in ACPI under _CRS.
> > In my firmware, I have defined two addresses for my device using
> > Memory32Fixed and QwordMemory under _CRS.
> > These  two addresses are 32-bit and 64-bit long respectively.
> > For Memory32Fixed, I gave DescriptorName name as REG0 and for
> > QwordMemory I gave DescriptorName as SATA.
> 
> Could you give us the ASL for the code snippet that you're talking about?
>

IIUC, something like below(a very rough example based on the description
above):

    Name (_CRS, ResourceTemplate (){
      QwordMemory (
        ResourceConsumer, PosDecode, MinFixed, MaxFixed, NonCacheable,
        ReadWrite, 0x0, 0x700100520, 0x700100523, 0x0, 4, , , "SATA",)
      Memory32Fixed(ReadWrite, 0x3200000, 0x10000, "REG0")
    }

Basically 2 or more entries of Memory/Address Space Resource Descriptor
which can be identified in OSPM by DescriptorName. IOW if a device has
2 sets of registers/memory/address space associated with it, instead of
relying on the order of declaration, identify them by the descriptor
name provided in ASL namespace.

--
Regards,
Sudeep
