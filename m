Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99C797CA5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjIGTVC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjIGTVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 15:21:02 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8769DCC;
        Thu,  7 Sep 2023 12:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie8SrLma7CrJtJAFpo/9E44VEviI3KACAGObGRSHGasBHms6f9q/Sr3Y0k0wAonetQBZvVdBV+1Ezj3X0NNbXRf+MZW4AZuW2Dqcpug+3QYOTP0WoU7NmV908mw0Lydy0LGTZAdhMdAD0A24fgrtX6vmEjPTmMi4yEk8rNa8QJ1VL9o1ZhDV/RZvibZvGBEli2bwx7hhvU/Yoha1MOY2/N9jYSUbwreNZe3CoEhUgv8nZtYp+Pn1X/+/Bt2oFpuENRZ+/8CNCogPkRSQI1w5oiAlswFNcGY0jGf3MrRZsZFSjCDqc+b9UWVZTkjLznZaSSUa+q4yCbueR64wXJkgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQAWG11tuzHRhowvg8nWv5VCKb+ZuhiNuVv3B8lZdxg=;
 b=ewx/oXs6ff9neEFFtXSrGfwTFMDS0Gi2Gnbb1im53bvJWbTXBK1s856CnjxP3zAyMJkGArrSc5Gmb6EfCG7w9PG0yPdxelRfSNoFvDbpXVYNhYHKUOptcG8UrCEM3sErbKMsivDOiPfsYIUZDvtzf6X4kbYYKNJQZSfQlgKKjH5tB3V8yUPRo8QKxCdvuklzdG7ykKCY02YeNGgaA6faVnjBLkYn1/SNcjVln6BLm5cis/XsRKgvxM5M0QvKf+VpLWt6z/4sHD4wLd+HQ540YcceIlqoS5xSlEYjCIaYPQtOOsVQl3pqp135LKjy2Cd8fOQEA/p4J1qG+03zpAuing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQAWG11tuzHRhowvg8nWv5VCKb+ZuhiNuVv3B8lZdxg=;
 b=YZ7T2JVllbxdsiFiAyCH5CtRayDipvB/mFUpdfEokfBTGv1EQkGPtkEEJISXqReKUxcWJMhWXGoRT8UjpNj9bJpzMwMq1NJMgdb50isIfcm20EF6FAW27zRjHuxljgIjMgjSTn9AT3eSyyWoI4hO9k4fpqQd8jEv1RzSXjQplHI=
Received: from PA7P264CA0124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::9)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 19:20:52 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10a6:102:36e:cafe::82) by PA7P264CA0124.outlook.office365.com
 (2603:10a6:102:36e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 19:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 19:20:51 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 7 Sep 2023 14:20:49 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v4 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Date:   Thu, 7 Sep 2023 14:19:54 -0500
Message-ID: <20230907191956.674833-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a522b34-ec3b-4233-9533-08dbafd78cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNlDEO83RUXtdUoc+EE+7zqDsWtiqRiizKtAL+crhW33wjgiwrMoL9Zh0iONudGatEdIGo4dEc51l7nwdH7Fnie0F1UGKsjgovKlnr1GNG87OniNO/6eBkCAVTN14fjiijv1sU1Fm7PwWUk+20iIj9SiRdQy/VbjPXZUDS06PtXKdQYRB4YxhAEBdEzph2kNNRRG3da6V0qmNHD5pJG00q98AZ1R3/wJqPuQFJLiIhFioF0t9MkBar06rGi1Z8fgvFGc9Q5twWu5UoZsjAniwzhX8OuTMOR7Dx4m0bj5TpMz8Djf6Tdxh0Dkf6IRQGp4Vz+czHCzDVJyrBpL7qs/U8fZ4vtDGOcwlBBg6jmnJKDjJtgeN+oJq0TctLiPK0iUkcs0i/Mnk2tGw3jx8X1tTuw5WlgffJB5fWhuHxp24L1+mnoYGQgIqXiyCSzLAwMesc416szX5RvH+aXGg978QLixEjkOAS6G/hqRsRdGDaMpEckwaBedKWAME7hPsu1B2rJVSXyVYLWm9m9fM2CS1ftoRKYUY+CcDyY6C2bCtBzSv/C1DC+viOI/sqIT2iLgzWXc43z8oUkDpMEQ8ZjCJESEveerQB0HRYWB7kmw8bI/BWDGud7rMPG/jMeUP0NhcnntrpXHHSaP5w/cbczRQXRIpjS3VQ0sS5M6X9l0PmIzM5oeGH6N2Ttm92LfiaEF0WLIH697RoaSZioaOmMcIB5y/V/2gNpYRytizEafDEFFj1jsxRGYnW94KgbNJc3/MS8ejUsQG3wpJFyI1QbhHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(36860700001)(82740400003)(2616005)(40460700003)(81166007)(26005)(16526019)(356005)(1076003)(7696005)(47076005)(36756003)(426003)(336012)(40480700001)(83380400001)(478600001)(8676002)(4326008)(8936002)(70586007)(70206006)(110136005)(5660300002)(54906003)(86362001)(316002)(2906002)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 19:20:51.7217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a522b34-ec3b-4233-9533-08dbafd78cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
device) for CXL RCH root ports. The file will print the RCRB base
MMIO address of the root port when read and will be used by
users looking to inject CXL EINJ error types for RCH hosts.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++++
 drivers/cxl/acpi.c                      |  2 ++
 drivers/cxl/core/port.c                 | 33 +++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  2 ++
 4 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 087f762ebfd5..a7d169235543 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -177,6 +177,14 @@ Description:
 		integer reflects the hardware port unique-id used in the
 		hardware decoder target list.
 
+What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
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
index 724be8448eb4..001ab8742e21 100644
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
@@ -930,11 +938,30 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
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
 static void cxl_dport_remove(void *data)
 {
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	if (dport->rch)
+		device_remove_file(dport->dport_dev, &dev_attr_cxl_rcrb_addr);
+
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
 	put_device(dport->dport_dev);
 }
@@ -1021,6 +1048,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE) {
+		rc = device_create_file(dport_dev, &dev_attr_cxl_rcrb_addr);
+		if (rc)
+			return ERR_PTR(rc);
+	}
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

