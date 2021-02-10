Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00540315DF6
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 04:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBJDz7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Feb 2021 22:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBJDz6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2021 22:55:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82465C061788
        for <linux-acpi@vger.kernel.org>; Tue,  9 Feb 2021 19:55:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p20so1474096ejb.6
        for <linux-acpi@vger.kernel.org>; Tue, 09 Feb 2021 19:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jcPhy12gzye0nrum1fWQ8j/97dv32Ns1Dw9byHAwWSM=;
        b=fTWgqvP5xroeBa0uosT4jaY2+FHBZVyHB8ZQUMQD7ZMgsj6HqEicQP2OrjX6O+23fo
         i/Y7aiPXxSj4ojCb0vxw2ASNRMt29g1CSe3+9gROlf7TUudMp6hmZ8n/S6/1DrybDH2c
         Lp9BpaL5XEO/wPK2Ox4sCCCHRI/AeaTgUAfqd9A9iXt77Z32KER2l9U54R6uPS2kCepi
         /H2YsANdHDcNnQZYKGigmY7oJ/5kMUXmx4WAvHYzjH5cOPiXmo4VdO48SBE1w/O87grN
         zLEsHSYpIA+KBWBgsQorFGW1JWgNZYEYBiTF65E0IY1FruGG5Om9jkFV/je0jEk2PgLI
         xpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jcPhy12gzye0nrum1fWQ8j/97dv32Ns1Dw9byHAwWSM=;
        b=p+t+pFd8/9Ut9I9Qno4q2fuxoJMNztN5jj98R33RdyWTO+N+u6sSKusToHn0DWtcQC
         G0SHHFDMEvp6UYLQVtrT7WY0rJWwYVydsL8qhWwWAZyqI0eU14sEH9NlUzy1MgBsiLxr
         8S9lmmWnjfU/7z15fn0SvEyERJ2UqF947jBw/Y3gmc8W8bxg60cZpafpbkYycCGGln4q
         cR8xLN8E1WbLvS0ahneIsW/glp8rDaCGOzmB4nKkapsxXeNI9NvjnLX3ld9Ugq1biBpG
         GsQ5EnXz9tRcKrV8Zqldlh9Z2RgvLtaqZtXOeOrrGzslkA5PF1TIUPo1d64un8D6KquS
         rX1Q==
X-Gm-Message-State: AOAM531i3Zn4Jp7fHdu3Cd5qRekFUQQiHM2UBsb8p0dgq+0ovnR+Csn1
        SxZGQ8GfHJC2DxG3zul3p2zFxAsW8TChbFi1kV1XJg==
X-Google-Smtp-Source: ABdhPJzbf7aIYsVkC0rupV41ULl79fB7wcZhHcYqzAxfaFn6/vt2ePk37+QQ4uFLpp9gAuDkBfFA3TaPCl0R9dJcdJU=
X-Received: by 2002:a17:906:ff48:: with SMTP id zo8mr1009855ejb.292.1612929317289;
 Tue, 09 Feb 2021 19:55:17 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Feb 2021 19:55:05 -0800
Message-ID: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
Subject: [RFC] ACPI Code First ECR: Generic Target
To:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While the platform BIOS is able to describe the performance
characteristics of CXL memory that is present at boot, it is unable to
statically enumerate the performance of CXL memory hot inserted
post-boot. The OS can enumerate most of the characteristics from link
registers and CDAT, but the performance from the CPU to the host
bridge, for example, is not enumerated by PCIE or CXL. Introduce an
ACPI mechanism for this purpose. Critically this is achieved with a
small tweak to how the existing Generic Initiator proximity domain is
utilized in the HMAT.

---

# Title: Introduce a Generic Target for CXL

# Status: Draft

# Document: ACPI Specification 6.4

# License
SPDX-License Identifier: CC-BY-4.0

# Submitter:
* Sponsor: Dan Williams, Intel
* Creators/Contributors:
    * Mahesh Natu, Intel
    * Chet Douglas, Intel
    * Deepak Shivakumar, Intel

# Summary of the Change
Introduce a "Generic Target" concept to the SRAT to describe the root
performance parameters in the path to dynamically discovered (outside of
ACPI enumeration) CXL memory target endpoints.

# Benefits of the Change
Consider the case of a system with a set of CXL host bridges (ACPI0016),
and no devices attached at initial system power-on. In this scenario
platform firmware is unable to perform the end-to-end enumeration
necessary to populate SRAT and HMAT for the endpoints that may be
hot-inserted behind those bridges post power-on. The address-range is
unknown so SRAT can not be pre-populated, the performance is unknown (no
CDAT nor interleave configuration) so HMAT can not be pre-populated.

However, what is known to platform firmware that generates the SRAT and
HMAT is the performance characteristics of the path between CPU and
Generic Initiators to the CXL host bridge target. With either
CPU-to-Generic-Target, or Generic-Initiator-to-Generic-Target entries in
the HMAT the OS CXL subsystem can enumerate the remaining details (PCIE
link status, device CDAT, interleave configuration) to calculate the
bandwidth and latency of a dynamically discovered CXL memory target.

# Impact of the Change
The existing Generic Initiator Affinity Structure (ACPI 6.4 Section
5.2.16.6) already contains all the fields necessary to enumerate a
generic target proximity domain. All that is missing is the
interpretation of that proximity domain optionally as a target
identifier in the HMAT.

Given that the OS still needs to dynamically enumerate and instantiate
the memory ranges behind the host bridge. The assumption is that
operating systems that do not support native CXL enumeration will ignore
this data in the HMAT, while CXL native enumeration aware environments
will use this fragment of the performance path to calculate the
performance characteristics.

# References
* Compute Express Link Specification v2.0,
<https://www.computeexpresslink.org/>

# Detailed Description of the Change

* Replace "Generic Initiator" with "Generic Initiator / Target" in all
locations except where an "initiator" or "target" is implied.
Specifically 5.2.27.3 "Memory Proximity Domain Attributes Structure"
need not replace occurrences of "generic initiator" in field: "Proximity
Domain for Attached Initiator". Additionally field: "Proximity Domain
for the Memory" must be renamed to "Proximity Domain for the Memory /
Generic Target" with a new description "Integer that represents the
memory / generic target proximity domain to which this memory belongs."

* Revise "5.2.16.6 Generic Initiator Affinity Structure" to make it
  consistent with being referenced as either a target or initiator.

        * Description: (replace all text)

        > The Generic Initiator / Target Affinity Structure provides the
        > association between a Generic Initiator and a Memory Proximity
        > Domain, or another Generic Target Proximity Domain. The
        > distinction as to whether this structure represents an
        > Initiator, a Target, or both depends on how it is referenced
        > in the HMAT. See Section 5.2.27.3 for details.

        > Support of Generic Initiator / Target Affinity Structures by
        > OSPM is optional, and the platform may query whether the OS
        > supports it via the _OSC method. See Section 6.2.11.2.

        * Architectural transactions: (append after current text)

        > If this proximity domain is referenced as a target then it
        > supports all the transaction types inferred above.

        * Other updates are simple Initiator => Initiator / Target
          replacements.
