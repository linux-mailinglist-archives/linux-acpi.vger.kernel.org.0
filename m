Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F1F704BFF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjEPLLr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjEPLLS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:11:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C47292;
        Tue, 16 May 2023 04:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684235415; x=1715771415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TbDFPPkO6oQQdWKo53x3LE6KWfww5hbCUtUF4G8tXCE=;
  b=Ee+Kr0jb9gZaHV8JdDGs45Ld/DnVDLrJBD/z+8Nsd+j0fET/9837yJ2h
   CXrawG4omSiydm6s2nsxZGw6Hy37LIgKfseeZ8xYIclIE7UaxdY+XgEpq
   WAL3I53/TJwQV/+I/FA4fNjCXWNtk9HJb+p5VTon3KW7L/MDkt76KBFhZ
   x4xpXhtsDs0NKthAt6rOeOob4zIL4OVKoHXOk5TmvXOJOLIMEbkDY/pSg
   8hhAWiYca7UCAnf3PggvyYf/MqTcuMzUarAlC5ddKArqcoXkSHJHOufbn
   yIiKbcZ5Ng6nV++DU+wAnRIKeCmZkanMtJkHp9Qj/G/8FjppPcBPhzUKr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379622175"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379622175"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="678819882"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="678819882"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:09:54 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 3D018120279;
        Tue, 16 May 2023 14:09:52 +0300 (EEST)
Date:   Tue, 16 May 2023 11:09:52 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZGNkgE5NHoSPm4a5@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-4-sakari.ailus@linux.intel.com>
 <1865464.tdWV9SEqCh@kreacher>
 <ZGNFgXM/463ycI6R@kekkonen.localdomain>
 <CAJZ5v0jcZsANJr5n7pAM2KR4c_kLkhbDC_docOA8iTVNq_WshA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jcZsANJr5n7pAM2KR4c_kLkhbDC_docOA8iTVNq_WshA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Tue, May 16, 2023 at 12:12:13PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Tue, May 16, 2023 at 10:57 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, May 15, 2023 at 06:45:10PM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, March 29, 2023 12:09:44 PM CEST Sakari Ailus wrote:
> > > > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > > > configuration, associate it with appropriate devices and allocate memory for
> > > > software nodes needed to create a DT-like data structure for drivers.
> > >
> > > It occurred to me, that there would be so many things I would like to change
> > > in this patch, so it would be better to create my own version of it, which
> > > is appended.
> > >
> > > It is based on
> > >
> > > https://patchwork.kernel.org/project/linux-acpi/patch/2694293.mvXUDI8C0e@kreacher/
> > >
> > > that has just been posted.
> > >
> > > IIUC, the idea is to extract the ACPI handle for each resource source in every
> > > _CRS CSI-2 resource descriptor and count how many times each handle appears in
> > > a CSI-2 context, either because it is referenced from a _CRS CSI-2 resource
> > > descriptor (as a "resource source"), or because its device object has CSI-2
> > > resource descriptors in _CRS.
> >
> > Correct.
> >
> > >
> > > This allows a set of software nodes to be allocated for each of these handles.
> > >
> > > If I got that totally wrong, please let me know.  Otherwise, I will rework the
> > > remaining patches in the series to match this one.
> >
> > It seems about right. I mostly see renames, moving the code around,
> > using the existing dependency list and then parsing sub-tree for _CRS CSI-2
> > objects right from the bus scan callback.
> >
> > It seems you've also moved the structs from internal.h to what is now
> > called mipi-disco-imaging.c.
> 
> No, I haven't moved anything in this direction, I've just dropped them.

Ah, I think the struct was added to scan.c by the earlier patch. Indeed, by
doing the _CRS CSI2 scanning right from the device scanning callback, it's
probably possible to omit these.

-- 
Regards,

Sakari Ailus
