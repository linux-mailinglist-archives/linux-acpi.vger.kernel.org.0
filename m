Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D29706F83
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjEQRe1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 13:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjEQReY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 13:34:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B201FFE;
        Wed, 17 May 2023 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684344863; x=1715880863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J1vTwWXDWOmB5KTcRXHCtG0ov/EzmpZpuFt2eQ7PAKw=;
  b=LFsPrCBUnAXcJVJI6oPECJ3aomwnqNRMc7yVX+BkmJEMyEdOJxmd1zhc
   wzoo4KKkSrbw8Zh4Fh36GCqzDOD59EpjfC/fEU9hSOGALFMGyVjlz8rC1
   xgKNWfkTJSPxJswO7TnWpH1Zwj1Fu+9CcX/BFvjYNYLAdnVJtiCQXcCr1
   8w24/fjufI3kMYw80nmbpVGjF+3LZuO/yDg/eCdEWxbtybw8BuBnhzHsT
   R92SB0gHdDWmSFfeLnxbClx4eH8DcKnrnvUXZwYzPgrYgoJXa9v6rekwf
   2mD3G8M6UdqxmVtcSuKoQHQulRaKjUZZmDZvjCjRnpdxdiN45soq1nkYZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336384339"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="336384339"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 10:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="846175229"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="846175229"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 10:34:21 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 6F1DD120C45;
        Wed, 17 May 2023 20:34:18 +0300 (EEST)
Date:   Wed, 17 May 2023 17:34:18 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZGUQGo/5A5+ET4OP@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-6-sakari.ailus@linux.intel.com>
 <CAJZ5v0gxqs3+ofqX0PGmM=3HOi96ioyYJis+RL2oACPq6rggEA@mail.gmail.com>
 <ZGS+RzCGl7Y3p6N/@kekkonen.localdomain>
 <CAJZ5v0i73bdo7oxv_hrj0qM0PQuk9cbRLQ4jqPbKn7V4nMqOhQ@mail.gmail.com>
 <CAJZ5v0hG-qGa==9cQz2-xK01JJxL2UZuL9u=5yaDo3rW9eL9eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hG-qGa==9cQz2-xK01JJxL2UZuL9u=5yaDo3rW9eL9eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 17, 2023 at 03:50:47PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 17, 2023 at 2:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, May 17, 2023 at 1:54 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> 
> [cut]
> 
> > > > > +                       local_port = &local_swnodes->ports[local_index];
> > > > > +                       local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
> > > > > +                       local_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(local_node);
> > > >
> > > > This looks odd.  Is local_port pointing to its own node as a remote
> > > > endpont, or am I confused?
> > >
> > > This is a reference to a software node that will be, in turn, referenced by
> > > the "remote-endpoint" property entry in the remote node. Look for
> > > ACPI_DEVICE_SWNODE_EP_REMOTE_EP a few lines below these.
> >
> > To be precise, IIUC, it is going to be the "remote-endpoint" value for
> > the remote node.
> >
> > OK, thanks for the explanation.  This isn't exactly straightforward TBH.
> 
> So I'd arrange it so that the value of the "remote-endpoint" property
> in a given node is stored in that node (the value itself being a
> reference to another endpoint).

Fine for me.

-- 
Sakari Ailus
