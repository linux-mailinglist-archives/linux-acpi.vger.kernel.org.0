Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9F709F45
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjESSm6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjESSmj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:42:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B2EE43;
        Fri, 19 May 2023 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684521758; x=1716057758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dMoEWzzSvgqrTqk8OTnPnCyPMuPKg8Vg30mm08/q1lw=;
  b=R0TYE3Yw25CD+JwTNSbwu09ashpIafyaiQDer0EEWXF75CyaA7AvYICV
   pOvdXxvTVc5q7WGheeiit+qKG9LPKa1cB/1WiGvU/PmsvRH3Yota8Sla8
   LHNY1maVn3WTg7Qu2/xteF/NjynmxN7o1eEVsLHxKEJtSChmN5MIEZalV
   BLLJMvMQK8UJP2RKXpQRw5YK/z9jRENMtuWRZd8a4PGMpPZVi6uuZkv5c
   SLVjXqi59GKLOFAl6Q720FDE3tdiQVNZHGdZdvYWFBylV7lmpzXHieNTM
   hJ8uJ/Jo6n58qbJ2iVfOl7LclQTID3jYySYaMHcXOvtW3tXh6UvQjq36I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="332057226"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="332057226"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 11:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="735610960"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="735610960"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 11:42:36 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 65BC5120867;
        Fri, 19 May 2023 21:42:33 +0300 (EEST)
Date:   Fri, 19 May 2023 18:42:33 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 08/10] ACPI: property: Rename parsed MIPI DisCo for
 Imaging properties
Message-ID: <ZGfDGRdB+oMXPMiz@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-9-sakari.ailus@linux.intel.com>
 <CAJZ5v0gFeN7WQQStjP80jdCM-yi2vaa9vyh-Smp9jOfjfv3wAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gFeN7WQQStjP80jdCM-yi2vaa9vyh-Smp9jOfjfv3wAA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Fri, May 19, 2023 at 08:34:34PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > MIPI DisCo for Imaging defines properties for sensor-adjacent devices such
> > as EEPROM, LED flash or lens VCM as either device or sub-node references.
> > This is compliant with existing DT definitions apart from property names.
> >
> > Rename parsed MIPI-defined properties so drivers will have a unified view
> > of them as defined in DT and already parsed by drivers.
> 
> I don't particularly like this idea.
> 
> One of the drawbacks is that if somebody doesn't care about DT
> bindings (for instance, because they will always run on platforms
> without DT), they won't be able to use the MIPI-defined property names
> in their code.
> 
> I would very much prefer to add a set of DT-defined properties with
> the same values.  The, whoever wants to use the property names from
> the DT bindings, they will be able to do that, but it will be also
> possible to use the MIPI-defined ones.
> 
> The previous patch adds the "rotation" property to the swnodes set, so
> I don't see any problems with doing that for the properties in
> question.

I don't think this would be a problem really, no, but I question the need
to ever access the MIPI specification names in Linux outside this piece of
code. Drivers for cameras, lens controllers and LED flashes generally try
to avoid being specific to a given firmware interface and the established
de facto naming of these properties in the kernel is aligned with
Devicetree.

I'd like to see differences only when the functionality differs, otherwise
they should be the same. Creating a copy when you can modify it is waste of
a bit of memory. On the upside, the object memory could remain const that
way.

-- 
Kind regards,

Sakari Ailus
