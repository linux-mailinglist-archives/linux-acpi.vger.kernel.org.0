Return-Path: <linux-acpi+bounces-1367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB407E616B
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 01:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDA01C20863
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 00:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE28A44
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBfxswuv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354EFDF67
	for <linux-acpi@vger.kernel.org>; Wed,  8 Nov 2023 23:30:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564825B2;
	Wed,  8 Nov 2023 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699486250; x=1731022250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sDGggQs47CObbC8qeaZj1TVKzgCjiVj9GqYw2S8QnGk=;
  b=eBfxswuvYgvPHLEs7iHVW+0kTxxMhtDvKeAJvrx5mvNOEQij0albpEUc
   W5fQ/XXgrvmx9A9aOZl+XGNQhCB5Oo/hDJHU1ZBmhBavbQpf0vk+ysSbc
   OE9gn3yJR+xYlDOiGtsodQo+7D5VtH0LDPnz1G2Dnrg+Nb9qZFyZsj684
   T73VU8pyn2ofe5WBkiPdCjewo7Yc4KK41xUCA+Bnlw3TnCnggel/UjPU7
   ITvI5hWU8BHXgUMI1qaUbADxyX/iEiYcJS+t/LyWaL9i5GXqtQmMxcMNg
   gNDy/3EL03ZVUYotiYGL3G62wgFmR6edizU0Yc52zx6B/T3JRi0wF+S1V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="11434839"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="11434839"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 15:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="739665046"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="739665046"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2023 15:30:47 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r0s0R-0008Ia-2f;
	Wed, 08 Nov 2023 23:30:43 +0000
Date: Thu, 9 Nov 2023 07:28:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [rafael-pm:acpi-mipi-disco-img 5/7]
 drivers/acpi/mipi-disco-img.c:536:42: warning: format '%d' expects argument
 of type 'int', but argument 4 has type 'long unsigned int'
Message-ID: <202311090735.0tfXwPGn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-mipi-disco-img
head:   54d87fab9fb060ff0489886ca0fdb101f6a3c03f
commit: a5dbdbb2bfb28643b71d23f75205845cb23af965 [5/7] ACPI: scan: Extract MIPI DisCo for Imaging data into swnodes
config: loongarch-randconfig-002-20231109 (https://download.01.org/0day-ci/archive/20231109/202311090735.0tfXwPGn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311090735.0tfXwPGn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090735.0tfXwPGn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/mipi-disco-img.c:21:
   drivers/acpi/mipi-disco-img.c: In function 'init_csi2_port':
>> drivers/acpi/mipi-disco-img.c:536:42: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
     536 |                 acpi_handle_info(handle, "Too few lane polarity bytes (%d vs. %d)\n",
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/acpi.h:1216:47: note: in definition of macro 'acpi_handle_info'
    1216 |         acpi_handle_printk(KERN_INFO, handle, fmt, ##__VA_ARGS__)
         |                                               ^~~
   drivers/acpi/mipi-disco-img.c:536:73: note: format string is defined here
     536 |                 acpi_handle_info(handle, "Too few lane polarity bytes (%d vs. %d)\n",
         |                                                                        ~^
         |                                                                         |
         |                                                                         int
         |                                                                        %ld


vim +536 drivers/acpi/mipi-disco-img.c

   481	
   482	static void init_csi2_port(struct acpi_device *adev,
   483				   struct acpi_device_software_nodes *swnodes,
   484				   struct acpi_device_software_node_port *port,
   485				   struct fwnode_handle *port_fwnode,
   486				   unsigned int port_index)
   487	{
   488		unsigned int ep_prop_index = ACPI_DEVICE_SWNODE_EP_CLOCK_LANES;
   489		acpi_handle handle = acpi_device_handle(adev);
   490		u8 val[ACPI_DEVICE_CSI2_DATA_LANES];
   491		int num_lanes = 0;
   492		int ret;
   493	
   494		if (GRAPH_PORT_NAME(port->port_name, port->port_nr))
   495			return;
   496	
   497		swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)] =
   498				SOFTWARE_NODE(port->port_name, port->port_props,
   499					      &swnodes->nodes[ACPI_DEVICE_SWNODE_ROOT]);
   500	
   501		ret = fwnode_property_read_u8(port_fwnode, "mipi-img-clock-lane", val);
   502		if (!ret)
   503			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_CLOCK_LANES)] =
   504				PROPERTY_ENTRY_U32("clock-lanes", val[0]);
   505	
   506		ret = fwnode_property_count_u8(port_fwnode, "mipi-img-data-lanes");
   507		if (ret > 0) {
   508			num_lanes = ret;
   509	
   510			if (num_lanes > ACPI_DEVICE_CSI2_DATA_LANES) {
   511				acpi_handle_info(handle, "Too many data lanes: %u\n",
   512						 num_lanes);
   513				num_lanes = ACPI_DEVICE_CSI2_DATA_LANES;
   514			}
   515	
   516			ret = fwnode_property_read_u8_array(port_fwnode,
   517							    "mipi-img-data-lanes",
   518							    val, num_lanes);
   519			if (!ret) {
   520				unsigned int i;
   521	
   522				for (i = 0; i < num_lanes; i++)
   523					port->data_lanes[i] = val[i];
   524	
   525				port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_DATA_LANES)] =
   526					PROPERTY_ENTRY_U32_ARRAY_LEN("data-lanes",
   527								     port->data_lanes,
   528								     num_lanes);
   529			}
   530		}
   531	
   532		ret = fwnode_property_count_u8(port_fwnode, "mipi-img-lane-polarities");
   533		if (ret < 0) {
   534			acpi_handle_debug(handle, "Lane polarity bytes missing\n");
   535		} else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
 > 536			acpi_handle_info(handle, "Too few lane polarity bytes (%d vs. %d)\n",
   537					 ret * BITS_PER_TYPE(u8), num_lanes + 1);
   538		} else {
   539			unsigned long mask = 0;
   540			int byte_count = ret;
   541			unsigned int i;
   542	
   543			/*
   544			 * The total number of lanes is ACPI_DEVICE_CSI2_DATA_LANES + 1
   545			 * (data lanes + clock lane).  It is not expected to ever be
   546			 * greater than the number of bits in an unsigned long
   547			 * variable, but ensure that this is the case.
   548			 */
   549			BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <= ACPI_DEVICE_CSI2_DATA_LANES);
   550	
   551			if (byte_count > sizeof(mask)) {
   552				acpi_handle_info(handle, "Too many lane polarities: %d\n",
   553						 byte_count);
   554				byte_count = sizeof(mask);
   555			}
   556			fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane-polarities",
   557						      val, byte_count);
   558	
   559			for (i = 0; i < byte_count; i++)
   560				mask |= (unsigned long)val[i] << BITS_PER_TYPE(u8) * i;
   561	
   562			for (i = 0; i <= num_lanes; i++)
   563				port->lane_polarities[i] = test_bit(i, &mask);
   564	
   565			port->ep_props[NEXT_PROPERTY(ep_prop_index, EP_LANE_POLARITIES)] =
   566					PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polarities",
   567								     port->lane_polarities,
   568								     num_lanes + 1);
   569		}
   570	
   571		swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =
   572			SOFTWARE_NODE("endpoint@0", swnodes->ports[port_index].ep_props,
   573				      &swnodes->nodes[ACPI_DEVICE_SWNODE_PORT(port_index)]);
   574	
   575		if (port->crs_csi2_local)
   576			init_csi2_port_local(adev, port, port_fwnode, ep_prop_index);
   577	}
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

