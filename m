Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6468D7067F7
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjEQMWi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 17 May 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEQMWh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 08:22:37 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A13C0C;
        Wed, 17 May 2023 05:22:36 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94a342f4c8eso16452566b.0;
        Wed, 17 May 2023 05:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326155; x=1686918155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9vpLl8En2po1hgvgZ4Kq++UySWYhDbpCJOGRfNDmMg=;
        b=VSVDF+VG5uPW4areUnP9uGpzNgtRYJ8+9AdhdN50OlQFhnwEICzWQZDjVmopt2e+yz
         fqGtyrnMX0G0N6wHRtoAukGvhca0lvkdRcIeu/Ll9FahHVD9U+vt36e2pBgNEvTOGyvV
         o6sdqBiTUv/Y8uL3qXo61l0AparC0lPNB2ClLx2/q6gp8ZKAZCBHQAb5i/xXqX40h9BZ
         uE6iimra5gxWuwy8e23UMWEt6JwVcCtWGfOSE/GihMoxwpRVNoA3xfRgI+Zyjxmtx2+u
         bc5690rhZvfDsJAdZ/5lgGNX2Ehwp69a3bXELmB/kbdu896cXt1A8+M4APPt7ExPdzzQ
         Xjbw==
X-Gm-Message-State: AC+VfDw4/ETuQ2H6mutPDd0wEj15xGxFnrNcmqMDjJJZrqntc0ZckPCd
        TfuAgjfy/NdFUJenxjAzW5qUtkVPS+FHmQ1nVebVz/MxQgA=
X-Google-Smtp-Source: ACHHUZ4r4R3Jz/cbFYFAFk/SLndjdWbI6379aMs7l1kQwehJXS/lZy++1xQRLQjnnpsmXwgYSLDVnxgeXbeYjWd8gOo=
X-Received: by 2002:a17:906:7391:b0:966:1f60:fd32 with SMTP id
 f17-20020a170906739100b009661f60fd32mr1762981ejl.6.1684326155140; Wed, 17 May
 2023 05:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-6-sakari.ailus@linux.intel.com> <CAJZ5v0gxqs3+ofqX0PGmM=3HOi96ioyYJis+RL2oACPq6rggEA@mail.gmail.com>
 <ZGS+RzCGl7Y3p6N/@kekkonen.localdomain>
In-Reply-To: <ZGS+RzCGl7Y3p6N/@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 14:22:23 +0200
Message-ID: <CAJZ5v0i73bdo7oxv_hrj0qM0PQuk9cbRLQ4jqPbKn7V4nMqOhQ@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 17, 2023 at 1:54 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> Thanks for the review.
>
> On Wed, May 17, 2023 at 12:53:43PM +0200, Rafael J. Wysocki wrote:
> > > +       list_for_each_entry(csi2, &ctx->crs_csi2_head, list) {
> > > +               struct acpi_device_software_nodes *local_swnodes;
> > > +               struct crs_csi2_instance *inst;
> > > +
> > > +               local_swnodes = crs_csi2_swnode_get(csi2->handle);
> > > +               if (WARN_ON_ONCE(!local_swnodes))
> > > +                       continue;
> > > +
> > > +               list_for_each_entry(inst, &csi2->buses, list) {
> > > +                       struct acpi_device_software_nodes *remote_swnodes;
> > > +                       struct acpi_device_software_node_port *local_port;
> > > +                       struct acpi_device_software_node_port *remote_port;
> > > +                       struct software_node *local_node, *remote_node;
> > > +                       unsigned int local_index, remote_index;
> > > +                       unsigned int bus_type;
> > > +
> > > +                       remote_swnodes = crs_csi2_swnode_get(inst->remote_handle);
> > > +                       if (WARN_ON_ONCE(!remote_swnodes))
> > > +                               continue;
> > > +
> > > +                       local_index = next_csi2_port_index(local_swnodes, inst->csi2.local_port_instance);
> > > +                       remote_index = next_csi2_port_index(remote_swnodes, inst->csi2.resource_source.index);
> > > +
> > > +                       if (WARN_ON_ONCE(local_index >= local_swnodes->num_ports) ||
> > > +                           WARN_ON_ONCE(remote_index >= remote_swnodes->num_ports))
> > > +                               goto out_free;
> > > +
> > > +                       switch (inst->csi2.phy_type) {
> > > +                       case ACPI_CRS_CSI2_PHY_TYPE_C:
> > > +                               bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_CPHY;
> > > +                               break;
> > > +                       case ACPI_CRS_CSI2_PHY_TYPE_D:
> > > +                               bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_DPHY;
> > > +                               break;
> > > +                       default:
> > > +                               acpi_handle_info(csi2->handle,
> > > +                                                "ignoring CSI-2 PHY type %u\n",
> > > +                                                inst->csi2.phy_type);
> > > +                               continue;
> > > +                       }
> > > +
> > > +                       local_port = &local_swnodes->ports[local_index];
> > > +                       local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
> > > +                       local_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(local_node);
> >
> > This looks odd.  Is local_port pointing to its own node as a remote
> > endpont, or am I confused?
>
> This is a reference to a software node that will be, in turn, referenced by
> the "remote-endpoint" property entry in the remote node. Look for
> ACPI_DEVICE_SWNODE_EP_REMOTE_EP a few lines below these.

To be precise, IIUC, it is going to be the "remote-endpoint" value for
the remote node.

OK, thanks for the explanation.  This isn't exactly straightforward TBH.
