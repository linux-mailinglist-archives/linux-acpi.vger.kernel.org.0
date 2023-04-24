Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08256ED720
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Apr 2023 00:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjDXWAH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 24 Apr 2023 18:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXWAH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2023 18:00:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE073C2B;
        Mon, 24 Apr 2023 15:00:03 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4zSm008kz682sD;
        Tue, 25 Apr 2023 05:55:03 +0800 (CST)
Received: from localhost (10.195.247.122) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 23:00:00 +0100
Date:   Mon, 24 Apr 2023 22:59:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 11/23] cxl: Add helper function that calculates QoS
 values for switches
Message-ID: <20230424225959.000046be@Huawei.com>
In-Reply-To: <cae21d42-ab7a-5d6c-a3ef-07f4c585dc9f@intel.com>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193572747.1178687.13347516490022640531.stgit@djiang5-mobl3>
        <20230420132624.00006334@Huawei.com>
        <86ec4cb5-14fd-9860-0fd9-ed53b474fe6e@intel.com>
        <cae21d42-ab7a-5d6c-a3ef-07f4c585dc9f@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.195.247.122]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 24 Apr 2023 10:31:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 4/24/23 10:09 AM, Dave Jiang wrote:
> > 
> > 
> > On 4/20/23 5:26 AM, Jonathan Cameron wrote:  
> >> On Wed, 19 Apr 2023 13:22:07 -0700
> >> Dave Jiang <dave.jiang@intel.com> wrote:
> >>  
> >>> The CDAT information from the switch, Switch Scoped Latency and 
> >>> Bandwidth
> >>> Information Strucutre (SSLBIS), is parsed and stored in an xarray 
> >>> under the
> >>> cxl_port. The QoS data are indexed by the downstream port id.  Walk 
> >>> the CXL
> >>> ports from endpoint to root and retrieve the relevant QoS information
> >>> (bandwidth and latency) that are from the switch CDAT. If read or 
> >>> write QoS
> >>> values are not available, then use the access QoS value.  
> >>
> >> I'd drop the access reference.  You already did that mapping from 
> >> access to read
> >> and write in earlier patch. Now we have no concept of access so 
> >> mentioning
> >> it will only potentially cause confusion.  
> > 
> > ok
> >   
> >>  
> >>>
> >>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >>>
> >>> ---
> >>> v3:
> >>> - Move to use 'struct node_hmem_attrs'
> >>> ---
> >>>   drivers/cxl/core/port.c |   81 
> >>> +++++++++++++++++++++++++++++++++++++++++++++++
> >>>   drivers/cxl/cxl.h       |    2 +
> >>>   2 files changed, 83 insertions(+)
> >>>
> >>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >>> index 3fedbabac1af..770b540d5325 100644
> >>> --- a/drivers/cxl/core/port.c
> >>> +++ b/drivers/cxl/core/port.c
> >>> @@ -1921,6 +1921,87 @@ bool schedule_cxl_memdev_detach(struct 
> >>> cxl_memdev *cxlmd)
> >>>   }
> >>>   EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
> >>> +/**
> >>> + * cxl_port_get_switch_qos - retrieve QoS data for CXL switches  
> >>
> >> Hmm. Terminology wise, this is called QoS data in either CXL spec
> >> or the HMAT stuff it came from.  I'd avoid that term here.
> >> Might also get confused with the QoS telemetry stuff from the CXL
> >> spec which is totally different or the QoS controls on an MLD
> >> which are perhaps indirectly related to these.
> >>
> >> QoS only gets involved once these are mapped to a QTG - assumption
> >> being that a given QoS policy should apply to devices of similar access
> >> characteristics.  
> > 
> > locality_info?  
> 
> Or perf_data in accordance with this doc:
> https://www.kernel.org/doc/html/v5.9/admin-guide/mm/numaperf.html

Either would be fine as far as I'm concerned.
I guess perf_data puts less of a spin on what it 'means' than
locality_info - so I'd slightly prefer that.

Jonathan

> 
> > 
> >   
> >>
> >> Other than that bikeshedding.
> >>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >>
> >>  
> >>> + * @port: endpoint cxl_port
> >>> + * @rd_bw: writeback value for min read bandwidth
> >>> + * @rd_lat: writeback value for total read latency
> >>> + * @wr_bw: writeback value for min write bandwidth
> >>> + * @wr_lat: writeback value for total write latency
> >>> + *
> >>> + * Return: Errno on failure, 0 on success. -ENOENT if no switch device
> >>> + */
> >>> +int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 
> >>> *rd_lat,
> >>> +                u64 *wr_bw, u64 *wr_lat)
> >>> +{
> >>> +    u64 min_rd_bw = ULONG_MAX;
> >>> +    u64 min_wr_bw = ULONG_MAX;
> >>> +    struct cxl_dport *dport;
> >>> +    struct cxl_port *nport;
> >>> +    u64 total_rd_lat = 0;
> >>> +    u64 total_wr_lat = 0;
> >>> +    struct device *next;
> >>> +    int switches = 0;
> >>> +    int rc = 0;
> >>> +
> >>> +    if (!is_cxl_endpoint(port))
> >>> +        return -EINVAL;
> >>> +
> >>> +    /* Skip the endpoint */
> >>> +    next = port->dev.parent;
> >>> +    nport = to_cxl_port(next);
> >>> +    dport = port->parent_dport;
> >>> +
> >>> +    do {
> >>> +        struct node_hmem_attrs *hmem_attrs;
> >>> +        u64 lat, bw;
> >>> +
> >>> +        if (!nport->cdat.table)
> >>> +            break;
> >>> +
> >>> +        if (!dev_is_pci(dport->dport))
> >>> +            break;
> >>> +
> >>> +        hmem_attrs = xa_load(&nport->cdat.sslbis_xa, dport->port_id);
> >>> +        if (xa_is_err(hmem_attrs))
> >>> +            return xa_err(hmem_attrs);
> >>> +
> >>> +        if (!hmem_attrs) {
> >>> +            hmem_attrs = xa_load(&nport->cdat.sslbis_xa, 
> >>> SSLBIS_ANY_PORT);
> >>> +            if (xa_is_err(hmem_attrs))
> >>> +                return xa_err(hmem_attrs);
> >>> +            if (!hmem_attrs)
> >>> +                return -ENXIO;
> >>> +        }
> >>> +
> >>> +        bw = hmem_attrs->write_bandwidth;
> >>> +        lat = hmem_attrs->write_latency;
> >>> +        min_wr_bw = min_t(u64, min_wr_bw, bw);
> >>> +        total_wr_lat += lat;
> >>> +
> >>> +        bw = hmem_attrs->read_bandwidth;
> >>> +        lat = hmem_attrs->read_latency;
> >>> +        min_rd_bw = min_t(u64, min_rd_bw, bw);
> >>> +        total_rd_lat += lat;
> >>> +
> >>> +        dport = nport->parent_dport;
> >>> +        next = next->parent;
> >>> +        nport = to_cxl_port(next);
> >>> +        switches++;
> >>> +    } while (next);
> >>> +
> >>> +    *wr_bw = min_wr_bw;
> >>> +    *wr_lat = total_wr_lat;
> >>> +    *rd_bw = min_rd_bw;
> >>> +    *rd_lat = total_rd_lat;
> >>> +
> >>> +    if (!switches)
> >>> +        return -ENOENT;
> >>> +
> >>> +    return rc;
> >>> +}
> >>> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_switch_qos, CXL);  
> >>
> >>  

