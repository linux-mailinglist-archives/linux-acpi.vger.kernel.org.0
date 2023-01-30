Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447C86818B7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjA3SWv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbjA3SWk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:22:40 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93845BD2;
        Mon, 30 Jan 2023 10:22:17 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id mc11so11880244ejb.10;
        Mon, 30 Jan 2023 10:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22MJfPAxydUVdhl0ZP7DuAbHPwrfeEL/jbNsu/UleHc=;
        b=BNB247ex98qLVfEF96GsiYkcbqtF3kOY9cTqolsTETyN8xv3JZdGbi2Wf3Q99ETER7
         eTCNr2FC/9NePXNxndqRUfWWU3hWS1J0l0rv8/AHLVVRfyLgTXVZI/IIin5CbtWyOf0s
         TErJuNetfBGvQ+6VtOmbbvvdaDvUEKQWslYiVkqpcuYXN4nStmRyiCM/pn91xmgM6vTC
         kgU5LsH6COOX4IP5iZsG3pRR/Vg/QKkuURwTXqiA2jOyhse4izHnZ9q0fGdz9A7sIbP0
         3AmbDUVmoVkY9uKJgKFYlwa6kIoirbK+Ubr49VpZyR8tfZfVA34JLKDPI0UagqKkXTZA
         oR+A==
X-Gm-Message-State: AO0yUKXeH2aNCj3DZ8n2aw+zlbY/EYQYXGVasngvsOhWopOohdBRSz0v
        rnBLDGvdBwrrz4o4IUUpw4EDHDPxd0BEBeLd07A=
X-Google-Smtp-Source: AK7set8yj9YPjpPvtIK810pfltfuDgOWCxWxxK5PxhAfmu1n2553bTDrRWEYh+Z4ZvV6fl62SSHaEjURsWkdwck2Wjg=
X-Received: by 2002:a17:906:95d7:b0:88a:30dc:5730 with SMTP id
 n23-20020a17090695d700b0088a30dc5730mr874290ejy.25.1675102883477; Mon, 30 Jan
 2023 10:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com> <20230125224101.401285-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20230125224101.401285-2-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 19:21:12 +0100
Message-ID: <CAJZ5v0g_KhDHRSOu_0tCtJPy9W1vMcXUF=qxc_6YJ=ADRNUv0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] ACPI: property: Parse data node string references
 in properties
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 25, 2023 at 11:41 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Add support for parsing property references using strings, besides
> reference objects that were previously supported. This allows also
> referencing data nodes which was not possible with reference objects.
>
> Also add pr_fmt() macro to prefix printouts.
>
> While at it, update copyright.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

While there is some design documentation in the last patch, at least
some pieces of it should go into the changelog of this patch IMO.

Also the spec-related information from the cover letter would be
useful here, because cover letters don't go into the git record.
