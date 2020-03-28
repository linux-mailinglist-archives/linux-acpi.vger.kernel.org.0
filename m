Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1419661E
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Mar 2020 13:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgC1MeN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Sat, 28 Mar 2020 08:34:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42362 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgC1MeN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2020 08:34:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id e4so11289605oig.9
        for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2020 05:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ntv4N/AS4WTrXXPqrVXfV4Dt01vquEXOEOKLI817Wdg=;
        b=qcL6iAxSKlLe4cwamC8A3IuCTu7tfPsRowu1KOIgV8f4AFjyqH7YtO8HLkE3TdPs/R
         q8qsb+Q49UhPEnsXoaxftNsYFnhnDY9F6dStO9MfRtX8eMq8su48YdgOQUERr4GKm7yh
         IQi+RuhGwrsRalvseUZCs56CBpOP3jJOFRqH1a26Yb/QOjDQwr4Z2q/aDYaRau4fijrR
         5pi7mUKDsdR+ga6bUXZnTNWnP3+tVpRQSbaS3o2vxZOyuO6/rBCpvkuAsKz0uteObu8x
         yljqKOJt/f+XWhBwagtLtU7S4BZnIMi7LVU0+7DschLA13fuyytPMVVPWzxEsUCE+Zh9
         fjQQ==
X-Gm-Message-State: ANhLgQ2bHHPinkypVmRNsXo/tIA8ibcvK7OiN59XNncKoD7SuAPJk1Gt
        /9AYBKUrzLNCWyjBFOPcL3K56Z9bgDjP5DbQaClOxA==
X-Google-Smtp-Source: ADFU+vt1TIHStCGdpC2EreHTYRmIRFsu9qT+PmiCBQCIN2gomNW6qFMco1pRRCOejMaq2UivNU955ncYKRhP3IaXq54=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr2331867oic.110.1585398852738;
 Sat, 28 Mar 2020 05:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 28 Mar 2020 13:34:01 +0100
Message-ID: <CAJZ5v0hyU2U80G8ZvJZsqPtMa-9p5p9U8sGX9Kby33wiR0qA2g@mail.gmail.com>
Subject: Re: [PATCH 00/10] ACPICA release 20200326
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 27, 2020 at 11:43 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This patch set contains the linux-ized patches of the ACPICA release
> version 20200326
>
> This release mostly consists of changes in the iASL compiler and the
> acpiexec utility so linux changes are quite small. The acpiexec
> change is specifically intended for the userspace utility's custom
> initialization feature so there is no functional change in the kernel
> space AML interpreter. Other than that, there were several additions to
> ACPI tables such a new IVRS subtype and NHLT as well as trivial typo
> fixes.
>
> Bob Moore (3):
>   ACPICA: Fix a typo in a comment field
>   ACPICA: Fixes for acpiExec namespace init file
>   ACPICA: Update version 20200326
>
> Cezary Rojewski (1):
>   ACPICA: Add NHLT table signature
>
> Erik Kaneda (3):
>   ACPICA: Change PlatformCommChannel ASL keyword to PCC
>   ACPICA: acpiexec: remove redeclaration of
>     acpi_gbl_db_opt_no_region_support
>   ACPICA: WSMT: Fix typo, no functional change
>
> John Levon (1):
>   ACPICA: utilities: fix sprintf()
>
> Michał Żygowski (2):
>   ACPICA: Implement IVRS IVHD type 11h parsing
>   ACPICA: Fix IVRS IVHD type 10h reserved field name

All applied as 5.7 material, thanks!
