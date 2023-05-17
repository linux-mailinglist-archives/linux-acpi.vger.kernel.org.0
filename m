Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C907065B7
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEQK4N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 17 May 2023 06:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQK4M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 06:56:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFF5FE4;
        Wed, 17 May 2023 03:55:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a342f4c8eso14033066b.0;
        Wed, 17 May 2023 03:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320836; x=1686912836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKeIw/TnmDyhGpNbAO0p58BQHrPamjgDrY0g2l07eRY=;
        b=YA0jolfdBpzLdpwFIW1vWSImIF5ItU8MgADgSzLKG+P8MxmjpiVncJoGEc6z5O+7SK
         wlrsgpPOp7lZKFbL9D3GcCVt0fdW3YIjFngk72BTJaCO5BXzb7uE9c52m1vxihX4m96R
         x6ucvs+QJICvYdLYmGm/I+Y6Gb/qmUGr6v/aSsB3Iv2BeiEItb0yoI+Wru+mI+XqKkga
         3uOBl8dUPEl8y4EGn0Bvpio3EWVEOTUWiSalwQy4Vgc1bzvDxuWddKsHcXYyM5jv5cWn
         tpVKM8lqile8uP6tHHN7x4J9pr/qYzLF9Rf/B2RBNceRSSZG3OirnGgS5JnuJiWWoIhi
         9jew==
X-Gm-Message-State: AC+VfDwqjKb1LfyX0SG3hJzKVWfO2QUKgM96XtdNBIyMbIvcRaqcBq7t
        aLJKsT7cQ4WgABVCQfiSNXBGY+mF158BZr9J6xcpV9Dv
X-Google-Smtp-Source: ACHHUZ4LxpbW1jraJut4i5Wm/5u3WDcNDacpknWnMUrPNwimm8L89RgY83qhLDbzI8SIOSb+JmulDt3NsHAzkhJXD1U=
X-Received: by 2002:a17:906:72c6:b0:953:2918:71e7 with SMTP id
 m6-20020a17090672c600b00953291871e7mr1504751ejl.5.1684320835519; Wed, 17 May
 2023 03:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <20230329100951.1522322-6-sakari.ailus@linux.intel.com>
In-Reply-To: <20230329100951.1522322-6-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 12:53:43 +0200
Message-ID: <CAJZ5v0gxqs3+ofqX0PGmM=3HOi96ioyYJis+RL2oACPq6rggEA@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Prepare generating software nodes for information parsed from ACPI _CRS for
> CSI-2 as well as MIPI DisCo for Imaging spec. The software nodes are
> compliant with existing ACPI or DT definitions and are parsed by relevant
> drivers without changes.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/internal.h |   3 +
>  drivers/acpi/mipi.c     | 358 +++++++++++++++++++++++++++++++++++++++-
>  drivers/acpi/scan.c     |  21 ++-
>  include/acpi/acpi_bus.h |  70 ++++++++
>  4 files changed, 449 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index aa5f9c69dbbe..1634a177c75e 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -304,9 +304,12 @@ static inline void acpi_init_lpit(void) { }
>                         ACPI _CRS CSI2 and MIPI DisCo for Imaging conversion
>    -------------------------------------------------------------------------- */
>
> +#define MIPI_IMG_PORT_PREFIX "mipi-img-port-"
> +
>  void acpi_crs_csi2_swnodes_del_free(void);
>  void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx);
>  void acpi_bus_scan_crs_csi2_release(struct list_head *crs_csi2_handles);
>  void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx);
> +void acpi_init_swnodes(struct acpi_device *device);
>
>  #endif /* _ACPI_INTERNAL_H_ */
> diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
> index d719c879eb83..03079f78bd2c 100644
> --- a/drivers/acpi/mipi.c
> +++ b/drivers/acpi/mipi.c
> @@ -3,7 +3,8 @@
>   * MIPI DisCo for Imaging support.
>   *
>   * Support MIPI DisCo for Imaging by parsing ACPI _CRS CSI2 records and DisCo
> - * for Imaging data structures.
> + * for Imaging data structures and generating nodes and properties using
> + * software nodes compliant with DT definitions of the similar scope.
>   *
>   * Also see <URL:https://www.mipi.org/specifications/mipi-disco-imaging>.
>   *
> @@ -20,6 +21,8 @@
>  #include <linux/sort.h>
>  #include <linux/string.h>
>
> +#include <media/v4l2-fwnode.h>
> +
>  #include "internal.h"
>
>  /* Temporary ACPI device handle to software node data structure mapping */
> @@ -31,6 +34,18 @@ struct crs_csi2_swnodes {
>
>  static LIST_HEAD(crs_csi2_swnodes);
>
> +/* Obtain pre-allocated software nodes for an ACPI device handle */
> +static struct acpi_device_software_nodes *crs_csi2_swnode_get(acpi_handle handle)
> +{
> +       struct crs_csi2_swnodes *swnodes;
> +
> +       list_for_each_entry(swnodes, &crs_csi2_swnodes, list)
> +               if (swnodes->handle == handle)
> +                       return swnodes->ads;
> +
> +       return NULL;
> +}
> +
>  static void crs_csi2_swnode_del_free(struct crs_csi2_swnodes *swnodes)
>  {
>         list_del(&swnodes->list);
> @@ -166,6 +181,35 @@ struct acpi_handle_ref {
>
>  #define NO_CSI2_PORT (UINT_MAX - 1)
>
> +/*
> + * Return next free entry in ports array of a software nodes related to an ACPI
> + * device.
> + */
> +static unsigned int next_csi2_port_index(struct acpi_device_software_nodes *ads,
> +                                        unsigned int port_nr)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < ads->num_ports; i++) {
> +               struct acpi_device_software_node_port *port = &ads->ports[i];
> +
> +               if (port->port_nr == port_nr)
> +                       return i;
> +
> +               if (port->port_nr == NO_CSI2_PORT) {
> +                       port->port_nr = port_nr;
> +                       return i;
> +               }
> +       }
> +
> +       return NO_CSI2_PORT;
> +}
> +
> +/* Print graph port name into a buffer, return non-zero if failed. */
> +#define GRAPH_PORT_NAME(var, num)                                          \
> +       (snprintf((var), sizeof(var), SWNODE_GRAPH_PORT_NAME_FMT, (num)) >= \
> +        sizeof(var))
> +
>  static int crs_handle_cmp(const void *__a, const void *__b)
>  {
>         const struct acpi_handle_ref *a = __a, *b = __b;
> @@ -258,6 +302,9 @@ static void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle han
>                           ports_count);
>  }
>
> +#define ACPI_CRS_CSI2_PHY_TYPE_C       0
> +#define ACPI_CRS_CSI2_PHY_TYPE_D       1
> +
>  /**
>   * acpi_bus_scan_crs_csi2 - Construct software nodes out of ACPI _CRS CSI2
>   *                         resource descriptors
> @@ -274,6 +321,8 @@ static void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle han
>   * 3. Allocate memory for swnodes each ACPI device requires later on, and
>   *    generate a list of such allocations.
>   *
> + * 4. Set up properties for software nodes.
> + *
>   * Note that struct acpi_device may not be available yet at this time.
>   *
>   * acpi_scan_lock in scan.c must be held when calling this function.
> @@ -339,5 +388,312 @@ void acpi_bus_scan_crs_csi2(struct acpi_scan_context_csi2 *ctx)
>                 this_count = this->count;
>         }
>
> +       /*
> +        * Allocate and set up necessary software nodes for each device and set
> +        * up properties from _CRS CSI2 descriptor.
> +        */
> +       list_for_each_entry(csi2, &ctx->crs_csi2_head, list) {
> +               struct acpi_device_software_nodes *local_swnodes;
> +               struct crs_csi2_instance *inst;
> +
> +               local_swnodes = crs_csi2_swnode_get(csi2->handle);
> +               if (WARN_ON_ONCE(!local_swnodes))
> +                       continue;
> +
> +               list_for_each_entry(inst, &csi2->buses, list) {
> +                       struct acpi_device_software_nodes *remote_swnodes;
> +                       struct acpi_device_software_node_port *local_port;
> +                       struct acpi_device_software_node_port *remote_port;
> +                       struct software_node *local_node, *remote_node;
> +                       unsigned int local_index, remote_index;
> +                       unsigned int bus_type;
> +
> +                       remote_swnodes = crs_csi2_swnode_get(inst->remote_handle);
> +                       if (WARN_ON_ONCE(!remote_swnodes))
> +                               continue;
> +
> +                       local_index = next_csi2_port_index(local_swnodes, inst->csi2.local_port_instance);
> +                       remote_index = next_csi2_port_index(remote_swnodes, inst->csi2.resource_source.index);
> +
> +                       if (WARN_ON_ONCE(local_index >= local_swnodes->num_ports) ||
> +                           WARN_ON_ONCE(remote_index >= remote_swnodes->num_ports))
> +                               goto out_free;
> +
> +                       switch (inst->csi2.phy_type) {
> +                       case ACPI_CRS_CSI2_PHY_TYPE_C:
> +                               bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_CPHY;
> +                               break;
> +                       case ACPI_CRS_CSI2_PHY_TYPE_D:
> +                               bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_DPHY;
> +                               break;
> +                       default:
> +                               acpi_handle_info(csi2->handle,
> +                                                "ignoring CSI-2 PHY type %u\n",
> +                                                inst->csi2.phy_type);
> +                               continue;
> +                       }
> +
> +                       local_port = &local_swnodes->ports[local_index];
> +                       local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
> +                       local_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(local_node);

This looks odd.  Is local_port pointing to its own node as a remote
endpont, or am I confused?

> +                       local_port->crs_csi2_local = true;
> +
> +                       remote_port = &remote_swnodes->ports[remote_index];
> +                       remote_node = &remote_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(remote_index)];
> +                       remote_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(remote_node);

Analogously here.
