Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4789922
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2019 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfHLJAN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Aug 2019 05:00:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44270 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfHLJAN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Aug 2019 05:00:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so105890999otl.11;
        Mon, 12 Aug 2019 02:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SfdkC+EgmsQaj7NNjroDPg/hus6U7Ms5CG+oO9tyUU=;
        b=efpMf5eqw2R010PUm3rOTyCTi1TyYzUtAzR21xW0YZfguL3O8a5Zt/4IRjLvGl4Ynp
         f7RREoo5LmOJqCCwLrkoMw5StV2s7w7RqA92jaP/7HnhEkYgFJ1RjtAoqW8P9Ura0RLD
         zWWXXHELnQfPpZ7wKSJl5g8od7xNNPs4yjlrAreNdvE2sMTt7heXrJvH6l0iB8qPP1bI
         TgzSwbw+vRIapZ0zTZRT9igCOf6qF0leIrHbHIzdWl85LhPaM4juFLVZgmY4qHMNNRLJ
         NuG9q/X+v8gWE2OZzH4fw4f3NTCSA0ha83QQCGDaPgB26xr7o9mskjXlAQcYNxYaUxuC
         xkyA==
X-Gm-Message-State: APjAAAUvssi09h1AuDWpDNHt+3Se2GJZwq4WCZXzsK9laEh9jy8Y1otT
        gzUE7akfAEt0kWX4/Dmh/LgdIaWQHbNDrGok+D4=
X-Google-Smtp-Source: APXvYqwXAkIlGfUoamy7KSLglTrn5vbwOWBEQTUqx7ej3O7a/v77b1NEyOivr1YHqaK+/R2qvF0MR2YOPgvp0o9peHU=
X-Received: by 2002:aca:d907:: with SMTP id q7mr13371583oig.68.1565600412611;
 Mon, 12 Aug 2019 02:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190805142706.22520-1-keith.busch@intel.com> <20190805142706.22520-4-keith.busch@intel.com>
In-Reply-To: <20190805142706.22520-4-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Aug 2019 10:59:58 +0200
Message-ID: <CAJZ5v0hCkibcbiYdPmBXdnDHZbGP2q0uNRi01oU0NMz5o3WwGA@mail.gmail.com>
Subject: Re: [PATCH 3/3] acpi/hmat: Skip publishing target info for nodes with
 no online memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 5, 2019 at 4:30 PM Keith Busch <keith.busch@intel.com> wrote:
>
> From: Dan Williams <dan.j.williams@intel.com>
>
> There are multiple scenarios where the HMAT may contain information
> about proximity domains that are not currently online. Rather than fail
> to report any HMAT data just elide those offline domains.
>
> If and when those domains are later onlined they can be added to the
> HMEM reporting at that point.
>
> This was found while testing EFI_MEMORY_SP support which reserves
> "specific purpose" memory from the general allocation pool. If that
> reservation results in an empty numa-node then the node is not marked
> online leading a spurious:
>
>     "acpi/hmat: Ignoring HMAT: Invalid table"
>
> ...result for HMAT parsing.
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

When you send somebody else's patches, you should sign them off as a
rule, but since you sent this one with your own R-by, I converted that
to a S-o-b.
