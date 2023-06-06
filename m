Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA68724151
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 13:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjFFLux (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jun 2023 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjFFLux (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 07:50:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57736A0;
        Tue,  6 Jun 2023 04:50:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF9D2F4;
        Tue,  6 Jun 2023 04:51:36 -0700 (PDT)
Received: from [10.57.73.174] (unknown [10.57.73.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7583F663;
        Tue,  6 Jun 2023 04:50:48 -0700 (PDT)
Message-ID: <c9b8469e-6e94-2e55-9b39-986f4eb581d3@arm.com>
Date:   Tue, 6 Jun 2023 12:50:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3 v2] Documentation/arm64: Update ARM and arch reference
To:     Jose Marinho <jose.marinho@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
References: <20230606093528.1494344-1-jose.marinho@arm.com>
 <20230606093528.1494344-2-jose.marinho@arm.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230606093528.1494344-2-jose.marinho@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-06-06 10:35, Jose Marinho wrote:
> This patch clarifies that both Armv8 and v9 are in scope, not
> just Armv8 systems.
> Also, ARM is re-written as Arm.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <Jeremy.Linton@arm.com>
> Cc: James Morse <James.Morse@arm.com>
> Cc: Rob Herring <Rob.Herring@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> 
> Signed-off-by: Jose Marinho <jose.marinho@arm.com>
> Reviewed-by: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
> ---
>   Documentation/arm64/arm-acpi.rst | 41 ++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> index 47ecb9930dde..1cafe38fc7f9 100644
> --- a/Documentation/arm64/arm-acpi.rst
> +++ b/Documentation/arm64/arm-acpi.rst
> @@ -1,40 +1,41 @@
> -=====================
> -ACPI on ARMv8 Servers
> -=====================
> +===================
> +ACPI on Arm systems
> +===================
>   
> -ACPI can be used for ARMv8 general purpose servers designed to follow
> -the ARM SBSA (Server Base System Architecture) [0] and SBBR (Server
> +ACPI can be used for Armv8 and Armv9 systems designed to follow
> +the Arm SBSA (Server Base System Architecture) [0] and SBBR (Server
>   Base Boot Requirements) [1] specifications.  Please note that the SBBR
>   can be retrieved simply by visiting [1], but the SBSA is currently only
>   available to those with an ARM login due to ARM IP licensing concerns.
>   
> -The ARMv8 kernel implements the reduced hardware model of ACPI version
> +
> +The Arm kernel implements the reduced hardware model of ACPI version
>   5.1 or later.  Links to the specification and all external documents
>   it refers to are managed by the UEFI Forum.  The specification is
>   available at http://www.uefi.org/specifications and documents referenced
>   by the specification can be found via http://www.uefi.org/acpi.
>   
> -If an ARMv8 system does not meet the requirements of the SBSA and SBBR,
> +If an Arm system does not meet the requirements of the BSA and BBR,
>   or cannot be described using the mechanisms defined in the required ACPI
>   specifications, then ACPI may not be a good fit for the hardware.
>   
>   While the documents mentioned above set out the requirements for building
> -industry-standard ARMv8 servers, they also apply to more than one operating
> +industry-standard Arm systems, they also apply to more than one operating
>   system.  The purpose of this document is to describe the interaction between
> -ACPI and Linux only, on an ARMv8 system -- that is, what Linux expects of
> +ACPI and Linux only, on an Arm system -- that is, what Linux expects of
>   ACPI and what ACPI can expect of Linux.
>   
>   
> -Why ACPI on ARM?
> +Why ACPI on Arm?
>   ----------------
>   Before examining the details of the interface between ACPI and Linux, it is
>   useful to understand why ACPI is being used.  Several technologies already
>   exist in Linux for describing non-enumerable hardware, after all.  In this
>   section we summarize a blog post [2] from Grant Likely that outlines the
> -reasoning behind ACPI on ARMv8 servers.  Actually, we snitch a good portion
> +reasoning behind ACPI on Arm systems.  Actually, we snitch a good portion
>   of the summary text almost directly, to be honest.
>   
> -The short form of the rationale for ACPI on ARM is:
> +The short form of the rationale for ACPI on Arm is:
>   
>   -  ACPI’s byte code (AML) allows the platform to encode hardware behavior,
>      while DT explicitly does not support this.  For hardware vendors, being
> @@ -47,7 +48,7 @@ The short form of the rationale for ACPI on ARM is:
>   
>   -  In the enterprise server environment, ACPI has established bindings (such
>      as for RAS) which are currently used in production systems.  DT does not.
> -   Such bindings could be defined in DT at some point, but doing so means ARM
> +   Such bindings could be defined in DT at some point, but doing so means Arm
>      and x86 would end up using completely different code paths in both firmware
>      and the kernel.
>   
> @@ -108,7 +109,7 @@ recent version of the kernel.
>   
>   Relationship with Device Tree
>   -----------------------------
> -ACPI support in drivers and subsystems for ARMv8 should never be mutually
> +ACPI support in drivers and subsystems for Arm should never be mutually
>   exclusive with DT support at compile time.
>   
>   At boot time the kernel will only use one description method depending on
> @@ -121,11 +122,11 @@ time).
>   
>   Booting using ACPI tables
>   -------------------------
> -The only defined method for passing ACPI tables to the kernel on ARMv8
> +The only defined method for passing ACPI tables to the kernel on Arm
>   is via the UEFI system configuration table.  Just so it is explicit, this
>   means that ACPI is only supported on platforms that boot via UEFI.
>   
> -When an ARMv8 system boots, it can either have DT information, ACPI tables,
> +When an Arm system boots, it can either have DT information, ACPI tables,
>   or in some very unusual cases, both.  If no command line parameters are used,
>   the kernel will try to use DT for device enumeration; if there is no DT
>   present, the kernel will try to use ACPI tables, but only if they are present.
> @@ -448,7 +449,7 @@ ASWG
>   ----
>   The ACPI specification changes regularly.  During the year 2014, for instance,
>   version 5.1 was released and version 6.0 substantially completed, with most of
> -the changes being driven by ARM-specific requirements.  Proposed changes are
> +the changes being driven by Arm-specific requirements.  Proposed changes are
>   presented and discussed in the ASWG (ACPI Specification Working Group) which
>   is a part of the UEFI Forum.  The current version of the ACPI specification
>   is 6.1 release in January 2016.
> @@ -456,7 +457,7 @@ is 6.1 release in January 2016.
>   Participation in this group is open to all UEFI members.  Please see
>   http://www.uefi.org/workinggroup for details on group membership.
>   
> -It is the intent of the ARMv8 ACPI kernel code to follow the ACPI specification
> +It is the intent of the Arm ACPI kernel code to follow the ACPI specification
>   as closely as possible, and to only implement functionality that complies with
>   the released standards from UEFI ASWG.  As a practical matter, there will be
>   vendors that provide bad ACPI tables or violate the standards in some way.
> @@ -470,12 +471,12 @@ likely be willing to assist in submitting ECRs.
>   
>   Linux Code
>   ----------
> -Individual items specific to Linux on ARM, contained in the Linux
> +Individual items specific to Linux on Arm, contained in the Linux
>   source code, are in the list that follows:
>   
>   ACPI_OS_NAME
>                          This macro defines the string to be returned when
> -                       an ACPI method invokes the _OS method.  On ARM64
> +                       an ACPI method invokes the _OS method.  On Arm64

Super-nit: that one should probably be just "Arm" as well, but then this 
whole section appears to be erroneous - I don't see anything in mainline 
obviously setting ACPI_OS_NAME to anything other than the ACPICA default 
of "Microsoft Windows NT", and there is no "acpi_os=" parameter - so it 
seems futile to worry about the trivialities within.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>                          systems, this macro will be "Linux" by default.
>                          The command line parameter acpi_os=<string>
>                          can be used to set it to some other value.  The
