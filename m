Return-Path: <linux-acpi+bounces-113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BFF7AE04E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 22:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ABE09281425
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426F23760
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65B179B4
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 20:02:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A29B;
	Mon, 25 Sep 2023 13:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLU7wd/CFGEb1J6yY1dUJhu8dBxSUMPpDdoz0xw3cgvKUwfugL6pA1pGCw/tyaJ8B6a4XEJReDLn00U7LDxunUYks1DtoeOy/UjRCiz6l4WsOfetWpQu7+tYL6hcl7FVbbjQmfwyaCZI92L3Mpt45UpU26q2rJozhber255w6pWOAZCcgFnMFaXLias0KC2eyQc3uNj0tQbIwdBt6aTFhJ/LrIjAw5N/NGGY+VMDHLwAZ0Uif03/vAEL/X84EyRNcNyO8Ac8ojJDpbr3PJoy4MvP5tEZQBgQVtmMeigNlcS7t/o0As9pxyjDR1U2wLdgLgD7T+vzhiLq12xqbUJPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytkOgpskYwZoJZVbt3J568BaIOsPqiD6LMACOafWDQ8=;
 b=O5LuN7TOt+MPSR3L4Kv4FZIDirq7MXWbUGkEGQSFOf69PM7lMZTcQ1rCYidKfz7N+1kaBnnoYxRLIjx1UpsLv9coowolCe54lreRl2zhxPWSmBTgf9y1kjBZ1yGgnTYm3hunHsztyCV6viSQ1Xdh8Yu49BfZUBcrPNJYTQm/LpH7QbZFws9lKppW9005TIdZLpokZUQBEDRpc1mJmsBDoXFdKKLt/40UTlYnaA5Bm0kSgTqlM3NaJoHf6hd1aICBwfvUwrCvzpLEGPcXYMPT+NbolEILZoBjI8+FHi5YxOHLxD0hgaHP+wdH7ibebEt1iYePlgci03mICuqDkvdK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytkOgpskYwZoJZVbt3J568BaIOsPqiD6LMACOafWDQ8=;
 b=nQTItpUeab2QMwxCadJbK6s0lQxxwc0USZs8+dhtIvEnpDvlEEiZntr7pngCxva6W8epL5WqA5vuelifcm5W++EsO9WfhEUYTZi1NFy/wnDELWSZCm2A5th6viCY6PIDH3OVqY1B/PGOAMFoIbQamo/JtfnQdplfoIHBh0e+WnM=
Received: from SN6PR05CA0023.namprd05.prod.outlook.com (2603:10b6:805:de::36)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:02:02 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::c5) by SN6PR05CA0023.outlook.office365.com
 (2603:10b6:805:de::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.18 via Frontend
 Transport; Mon, 25 Sep 2023 20:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 20:02:02 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 25 Sep 2023 15:02:01 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
	<yazen.ghannam@amd.com>
Subject: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Date: Mon, 25 Sep 2023 15:01:25 -0500
Message-ID: <20230925200127.504256-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: a3daca96-f63b-4f24-90a7-08dbbe0248c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ar0oKXISdewBSjhI7ZCNkTHJI61WZtkwtNNUrKWl9oOpMRPalRpObVkn4UaG0Li4vFkexpF8kqcZTwpOBG2Qg+AbAxE97OfUr1IFzI3ySl6S9KxrNTY15wIGBEkKBfNDLmd1oIg5qJP7Ne1j+RU3/qQASNrA4EUzwcpYdt0s3sLcexp8uj8NbnDhEpIpXTg+MYkQ0yU49iu5URgOVVi3cZ9qKs8PeeCJxSzKQElEm/DD5e60cjj4uRov5fMGe5fv3X6h1v98vhg4upK+nYorWvlnJy94Iy7/y7ScrbZXLISYw3MVUtoPCMVgVHvUGe+IUqPvU9Rnu87WeGCXqQBqlqrL5HkN3Kl7YCLnIq54/A9C2t8HQIK+VRVgwQc+9roOL2aRGFkOudFdUG+xQg+fQVkr70p6kIGrP4qPnSKD2iBXBHv46Mt8tgppUG+EDQ1m2LhetZOLTSmHlfhODsYEZuGAO7pHOLiaWsdEX3seEbzQz4ixjpKrgDuEDIEDJmwLbAADdbVD22T91/102tTlysZT4nHtu2EWovb+9tfjiWRY/hX0P7szixMmSxBFJjP5aY1eU8K+8MyJ50KvZTHp1TwI5Vx2c7aw2rumK4rrKlHK6SHmxF9wbM5YyDr22hHGiynCILkEiXCB1fPOWflkIBaAXyNYkkSJHcjjsYmKC4wWpcuLbvBuKgx0MkVUIxmTZHzWKYkFjRNYS+4dVlGxOm+8jJ5/8gHFoUK+vev6NRL7FLQx8uT9rcwWSGHbDib22gHy0BtXdaeyzRh+5YBcFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(46966006)(36840700001)(2906002)(316002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(54906003)(70206006)(70586007)(110136005)(478600001)(6666004)(2616005)(1076003)(26005)(16526019)(426003)(336012)(7696005)(40460700003)(83380400001)(47076005)(36860700001)(82740400003)(81166007)(356005)(36756003)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:02:02.2354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3daca96-f63b-4f24-90a7-08dbbe0248c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
device) for CXL RCH root ports. The file will print the RCRB base
MMIO address of the root port when read and will be used by
users looking to inject CXL EINJ error types for RCH hosts.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  9 ++++
 drivers/cxl/acpi.c                      |  2 +
 drivers/cxl/core/port.c                 | 58 +++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  2 +
 4 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 087f762ebfd5..85621da69296 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -177,6 +177,15 @@ Description:
 		integer reflects the hardware port unique-id used in the
 		hardware decoder target list.
 
+What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
+What:		/sys/devices/pciX/cxl_rcrb_addr
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The 'cxl_rcrb_addr' device file gives the MMIO base address
+		of the RCRB of the corresponding CXL 1.1 downstream port. Only
+		present for CXL 1.1 dports.
 
 What:		/sys/bus/cxl/devices/decoderX.Y
 Date:		June, 2021
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d1c559879dcc..3e2ca946bf47 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -676,6 +676,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 
+	set_cxl_root(root_port);
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..c3914e73f67e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -875,6 +875,14 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
+static struct cxl_port *cxl_root;
+
+void set_cxl_root(struct cxl_port *root_port)
+{
+	cxl_root = root_port;
+}
+EXPORT_SYMBOL_NS_GPL(set_cxl_root, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
@@ -930,11 +938,56 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
 		device_unlock(&port->dev);
 }
 
+static ssize_t cxl_rcrb_addr_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_dport *dport;
+
+	if (!cxl_root)
+		return -ENODEV;
+
+	dport = cxl_find_dport_by_dev(cxl_root, dev);
+	if (!dport)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%llx\n", (u64) dport->rcrb.base);
+}
+DEVICE_ATTR_RO(cxl_rcrb_addr);
+
+static umode_t cxl_rcrb_addr_is_visible(struct kobject *kobj,
+					struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_dport *dport;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ) || !cxl_root)
+		return 0;
+
+	dport = cxl_find_dport_by_dev(cxl_root, dev);
+	if (!dport || !dport->rch || dport->rcrb.base == CXL_RESOURCE_NONE)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute *cxl_rcrb_addr_attrs[] = {
+	&dev_attr_cxl_rcrb_addr.attr,
+	NULL,
+};
+
+static const struct attribute_group cxl_rcrb_addr_group = {
+	.attrs = cxl_rcrb_addr_attrs,
+	.is_visible = cxl_rcrb_addr_is_visible,
+};
+
 static void cxl_dport_remove(void *data)
 {
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	if (dport->rch)
+		sysfs_remove_group(&dport->dport_dev->kobj, &cxl_rcrb_addr_group);
+
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
 	put_device(dport->dport_dev);
 }
@@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
+	if (rc)
+		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
+			rc);
+
 	return dport;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..4d5bce4bae7e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -690,6 +690,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
+void set_cxl_root(struct cxl_port *root_port);
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
-- 
2.34.1


